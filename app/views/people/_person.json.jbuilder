json.extract! person, :id, :identification, :date_of_birth,
  :last_name, :first_names, :gender,
  :email, :phone, :address, :postcode_id, :municipality_id,
  :language, :nationality, :education_level_id, :education_info,
  :accommodation, :disabilities,
  :created_at, :updated_at
json.url person_url(person, format: :json) unless person.new_record?
