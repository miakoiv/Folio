require 'net/ftp'
require 'zip'
require 'activerecord-import/base'
ActiveRecord::Import.require_adapter 'mysql2'

namespace :db do
  desc 'Import Finnish postcodes from posti.fi via FTP'

  task postcodes: :environment do

    tempfile = Tempfile.new 'postcodes'

    # Downloads the contents of the latest PCF file at
    # ftp://webpcode:webpcode@ftp2.itella.com/
    Net::FTP.open 'ftp2.itella.com' do |ftp|
      ftp.login 'webpcode', 'webpcode'
      file = ftp.nlst.find { |f| f.start_with? 'PCF' }
      puts "[postcodes] downloading file #{file}"
      ftp.getbinaryfile file, tempfile.path
      ftp.close
    end

    puts "[postcodes] unzipping and parsing"
    tempfile.rewind
    postcodes = []
    municipalities = []
    line_format = '@13A5A30A30@176A3A20A20'

    # Extracts the file from the zip package and parses
    # its lines for postal code, postal code name, and
    # municipality in two languages
    Zip::File.open tempfile do |zipfile|
      zipfile.first.get_input_stream.each_line do |line|
        fields = line.unpack line_format
        fields.each { |f| f.encode! 'utf-8', 'iso-8859-1' }
        pcode, pname_fi, pname_sv, mcode, mname_fi, mname_sv = fields
        mid = mcode.to_i
        postcodes << Postcode.new(
          code: pcode,
          name_fi: pname_fi,
          name_sv: pname_sv,
          municipality_id: mid
        )
        municipalities[mid] ||= Municipality.new(
          id: mid,
          name_fi: mname_fi,
          name_sv: mname_sv
        )
      end
    end

    if postcodes.any?
      Postcode.delete_all
      Municipality.delete_all
      postcodes.sort_by!(&:code)
      municipalities.compact!
      puts "[postcodes] importing #{postcodes.count} postcodes"
      puts "[postcodes] and #{municipalities.count} municipalities"
      Postcode.import postcodes
      Municipality.import municipalities
    end

    tempfile.close
    tempfile.unlink
  end
end
