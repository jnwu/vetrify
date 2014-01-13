Rails.application.config.middleware.use OmniAuth::Builder do
	# LinkedIn
	id = Key.find_by api: 'linkedin', tag: 'client_id'
	secret = Key.find_by api: 'linkedin', tag: 'client_secret' 
	provider :linkedin, id.key, secret.key, :scope => 'r_fullprofile r_emailaddress', :fields => ["id", "email-address", "first-name", "last-name", "picture-url", "location", "positions", "educations"]

	# Github
	id = Key.find_by api: 'github', tag: 'client_id'
	secret = Key.find_by api: 'github', tag: 'client_secret' 
	provider :github, id.key, secret.key, scope: "user,repo"
end