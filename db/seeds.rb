# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Unit.create(id: 1, name_fi: 'Paikallinen toimisto')

EducationLevel.create([
  {id:  1, name_fi: 'Peruskoulussa'},
  {id:  2, name_fi: 'Peruskoulu keskeytynyt'},
  {id:  3, name_fi: 'Peruskoulu suoritettu'},
  {id:  4, name_fi: 'Lukiossa'},
  {id:  5, name_fi: 'Lukio keskeytynyt'},
  {id:  6, name_fi: 'Lukio suoritettu'},
  {id:  7, name_fi: 'Ylioppilas'},
  {id:  8, name_fi: 'Suorittamassa ammatillista perustutkintoa'},
  {id:  9, name_fi: 'Keskeytynyt ammatillinen perustutkinto'},
  {id: 10, name_fi: 'Ammatillinen perustutkinto suoritettu'},
  {id: 11, name_fi: 'Keskeytynyt alempi korkeakoulututkinto'},
  {id: 12, name_fi: 'Alempi korkeakoulututkinto suoritettu'},
  {id: 13, name_fi: 'Keskeytynyt ylempi korkeakoulututkinto'},
  {id: 14, name_fi: 'Ylempi korkeakoulututkinto'},
  {id: 15, name_fi: 'Muu tutkinto', needs_info: true},
  {id: 16, name_fi: 'Lähtömaassa suoritettu tutkinto', needs_info: true},
])

Referrer.create([
  {id:  1, name_fi: 'Perusopetus'},
  {id:  2, name_fi: 'Toisen asteen opetus'},
  {id:  3, name_fi: 'Lukio'},
  {id:  4, name_fi: 'Nuorisotyö (alueellinen ja ehkäisevä)'},
  {id:  5, name_fi: 'Koulu- ja opiskeluterveyden huolto'},
  {id:  6, name_fi: 'Perhekeskus'},
  {id:  7, name_fi: 'Nuorisokeskus'},
  {id:  8, name_fi: 'Lapsiperheiden sosiaalipalvelut'},
  {id:  9, name_fi: 'Terveydenhuollon peruspalvelut'},
  {id: 10, name_fi: 'Sosiaali- ja erityispalvelut'},
  {id: 11, name_fi: 'Huoltajat / sukulaiset'},
  {id: 12, name_fi: 'Kaverit'},
  {id: 13, name_fi: 'Sidosryhmät'},
  {id: 14, name_fi: 'Itsenäisesti'},
  {id: 15, name_fi: 'Kela'},
  {id: 16, name_fi: 'Työ- ja elinkeinotoimisto'},
  {id: 17, name_fi: 'HUS'},
  {id: 18, name_fi: 'Puolustusvoimat / siviilipalvelus'},
  {id: 19, name_fi: 'Muuta kautta', needs_info: true},
])
