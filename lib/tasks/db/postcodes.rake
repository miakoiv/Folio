require 'activerecord-import/base'
ActiveRecord::Import.require_adapter 'mysql2'

namespace :db do
  desc 'Import Finnish postcodes from posti.fi via HTTPS'

  task postcodes: :environment do

    # Downloads the contents of the latest PCF file at
    # https://www.posti.fi/webpcode/
    idx = HTTParty.get('https://www.posti.fi/webpcode/unzip/').parsed_response
    html = Nokogiri::HTML idx
    url = html.xpath('//a').find { |a| /PCF_\d+\.dat/.match(a['href']) }['href']
    puts "[postcodes] downloading file at #{url}"
    file = HTTParty.get(url).parsed_response

    postcodes = []
    municipalities = []
    line_format = '@13A5A30A30@176A3A20A20'

    # Parses the file for postal code, postal code name, and
    # municipality in two languages
    file.each_line do |line|
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
  end
end
