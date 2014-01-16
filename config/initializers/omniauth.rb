Rails.application.config.middleware.use OmniAuth::Builder do
	# LinkedIn
	id = Api.find_by provider: 'linkedin', tag: 'client_id'
	secret = Api.find_by provider: 'linkedin', tag: 'client_secret' 
	provider :linkedin, id.key, secret.key, :scope => 'r_fullprofile r_emailaddress', :fields => ["id", "email-address", "first-name", "last-name", "picture-url", "location", "positions", "educations"]

	# Github
	id = Api.find_by provider: 'github', tag: 'client_id'
	secret = Api.find_by provider: 'github', tag: 'client_secret' 
	provider :github, id.key, secret.key, scope: "user,repo"
end