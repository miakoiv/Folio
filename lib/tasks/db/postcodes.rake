require 'net/ftp'
require 'zip'
require 'activerecord-import/base'
ActiveRecord::Import.require_adapter 'mysql2'

namespace :db do
  desc 'Import Finnish postcodes from posti.fi via FTP'

  task postcodes: :environment do

    # Downloads the contents of the latest PCF file at
    # ftp://webpcode:webpcode@ftp2.itella.com/
    postcodes = []
    tempfile = Tempfile.new 'postcodes'

    Net::FTP.open 'ftp2.itella.com' do |ftp|
      ftp.login 'webpcode', 'webpcode'
      file = ftp.nlst.find { |f| f.start_with? 'PCF' }
      puts "[postcodes] downloading file #{file}"
      ftp.getbinaryfile file, tempfile.path
      ftp.close
    end

    puts "[postcodes] unzipping and parsing"
    tempfile.rewind

    Zip::File.open tempfile do |zipfile|
      zipfile.first.get_input_stream.each_line do |line|
        line.encode! 'utf-8', 'iso-8859-1'
        code, town, type = line.unpack '@13A5@18A30@110A'
        postcodes << Postcode.new(
          code: code,
          town: town
        )
      end
    end

    if postcodes.any?
      puts "[postcodes] importing #{postcodes.count} records"
      Postcode.delete_all
      postcodes.sort_by!(&:code)
      Postcode.import postcodes
    end

    tempfile.close
    tempfile.unlink
  end
end
