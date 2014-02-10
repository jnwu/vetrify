namespace :token do
	task :update => :environment do
		Applicant.all.each do |a|
            rand = SecureRandom.base64
            rand = SecureRandom.base64 while Token.find_by(key: rand) || rand.match(/\+/) || rand.match(/\//)

	        a.token = Token.create unless a.token
	        a.token.key = rand
	        a.token.save
		end
	end
end