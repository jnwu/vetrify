Rails.application.config.middleware.use OmniAuth::Builder do
	# LinkedIn
	id = Key.find_by api: 'linkedin', tag: 'client_id'
	secret = Key.find_by api: 'linkedin', tag: 'client_secret' 
	provider :linkedin, id.key, secret.key
	#:scope => 'r_fullprofile r_emailaddress r_network', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]

	# Github
	id = Key.find_by api: 'github', tag: 'client_id'
	secret = Key.find_by api: 'github', tag: 'client_secret' 
	provider :github, id.key, secret.key

	# Google
	id = Key.find_by api: 'google_oauth2', tag: 'client_id'
	secret = Key.find_by api: 'google_oauth2', tag: 'client_secret' 
	provider :google_oauth2, id.key, secret.key
	
	# Stackexchange
	id = Key.find_by api: 'stackexchange', tag: 'client_id'
	key = Key.find_by api: 'stackexchange', tag: 'client_key' 
	secret = Key.find_by api: 'stackexchange', tag: 'client_secret' 
	provider :stackexchange, id.key, secret.key, public_key: key.key
end