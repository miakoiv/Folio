json.extract! person, :id, :identification, :last_name, :first_names, :gender, :email, :phone, :address, :municipality, :language, :nationality, :accommodation, :restrictions, :referrals, :information, :created_at, :updated_at
json.url person_url(person, format: :json)