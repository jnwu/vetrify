json.array!(@applicants) do |applicant|
  json.extract! applicant, :id, :first_name, :last_name, :email, :password, :password, :password_digest
  json.url applicant_url(applicant, format: :json)
end
