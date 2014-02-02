namespace :list do
	BASE = "http://www.vetrify.com/applicant"
	task :fetch => :environment do
		urls = []
		Applicant.all.each do |a|
			next unless a.token
			u = {}
			u[:name] = "#{a.first_name} #{a.last_name}"
			u[:email] = "#{a.email}"
			u[:url] = "#{BASE}/#{a.id}/#{a.token.key}"
			urls.push u
		end
		SessionsHelper::MandrillHelper.raw ENV['email'], urls.to_s
	end
end