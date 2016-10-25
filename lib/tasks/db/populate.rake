namespace :db do
  desc 'Populate the people table with randomly generated data'
  task populate: :environment do

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
  end
end
