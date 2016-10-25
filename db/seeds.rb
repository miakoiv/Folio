# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = HTTParty
  .get('https://randomuser.me/api?results=250&nat=fi&exc=login,registered')
  .parsed_response['results']

postcodes = Postcode.all

records.each do |r|
  postcode = postcodes.sample

  person = Person.create(
    identification: r['id']['value'],
    date_of_birth: r['dob'],
    gender: r['gender'].first,
    last_name: r['name']['last'].capitalize,
    first_names: r['name']['first'].capitalize,
    address: r['location']['street'].titleize,
    postcode: postcode,
    municipality: postcode.municipality,
    email: r['email'],
    phone: r['cell'],
    language: 'fi',
    nationality: r['nat']
  )
  person.images.create attachment_remote_url: r['picture']['large']
end
