# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

people = HTTParty
  .get('https://randomuser.me/api?results=250&nat=fi&exc=login,registered')
  .parsed_response['results']

postcodes = Postcode.all

people.each do |person|
  postcode = postcodes.sample

  Person.create(
    identification: person['id']['value'],
    date_of_birth: person['dob'],
    gender: person['gender'].first,
    last_name: person['name']['last'].capitalize,
    first_names: person['name']['first'].capitalize,
    address: person['location']['street'].titleize,
    postcode: postcode,
    municipality: postcode.municipality,
    email: person['email'],
    phone: person['cell'],
    language: 'fi',
    nationality: person['nat']
  )
end
