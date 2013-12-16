json.array!(@business_users) do |business_user|
  json.extract! business_user, :id, :business_id, :email, :first_name, :last_name, :title, :password, :password_digest
  json.url business_user_url(business_user, format: :json)
end
