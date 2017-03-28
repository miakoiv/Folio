namespace :db do
  desc 'Populate the database with random people and customers'
  task populate: :environment do

    records = HTTParty
      .get('https://randomuser.me/api?results=100&nat=fi&exc=login')
      .parsed_response['results']

    units = Unit.all
    postcodes = Postcode.all
    statuses = Status.all
    referrers = Referrer.all

    records.each do |r|
      creation = Date.parse(r['registered'])
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
        nationality: r['nat'],
        created_at: creation,
        updated_at: creation
      )
      person.images.create attachment_remote_url: r['picture']['large']

      rand(3).times do |n|
        unit = units.sample
        contact = unit.users.sample
        started = creation + rand(1500).days

        person.customers.create(
          unit: unit,
          contacts: [contact],
          status: statuses.sample,
          referrer: referrers.sample,
          started_at: started,
          created_at: started
        )
      end
    end
  end
end
