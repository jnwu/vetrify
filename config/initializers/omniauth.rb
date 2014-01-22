Rails.application.config.middleware.use OmniAuth::Builder do
	provider :linkedin, '75qairvgqfo2xn', 'V2l4Rn3Efm2SW100', :scope => 'r_fullprofile r_emailaddress', :fields => ["id", "email-address", "first-name", "last-name", "picture-url", "public-profile-url", "location", "positions", "educations"]
	provider :github, '010d4e6a46d2d8deaf0b', '5d59eb9a1b77eecbe43c77c7cce704e0a960cfd4', scope: 'user, public_repo'
end
