# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Unit.create(id: 1, name_fi: 'Paikallinen toimisto')

User.create(
  id: 1,
  email: 'rosenblad@gmail.com',
  last_name: 'Rosenblad',
  first_names: 'Sami',
  password: 'rush2112',
  password_confirmation: 'rush2112'
)
