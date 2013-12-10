json.array!(@posts) do |post|
  json.extract! post, :id, :business_id, :position, :summary, :desired_skills, :expected_skills, :start_at, :expire_at
  json.url post_url(post, format: :json)
end
