json.extract! user, :id, :email, :last_name, :first_names, :activates_at, :expires_at, :created_at, :updated_at
json.url user_url(user, format: :json)