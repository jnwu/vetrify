require 'json'
require 'net/http'
require 'net/https'

module SessionsHelper
	def get uri
		http = Net::HTTP.new(uri.host, uri.port)
		http.read_timeout = 15
		http.use_ssl = true if (uri.scheme == 'https')
		http.start do
			request = Net::HTTP::Get.new uri.request_uri
			return http.request request
		end
	end

	def post uri, payload
		http = Net::HTTP.new(uri.host, uri.port)
		http.read_timeout = 15
		http.use_ssl = true if (uri.scheme == 'https')
		http.start do
			request = Net::HTTP::Post.new uri.request_uri
			request.body = payload
			return http.request request
		end
	end

	class LinkedInHelper
		def self.user info
	        a = Applicant.find_by email: info[:email]

	        unless a
		      	a = Applicant.create(
			        email:      	info[:email],
			        first_name: 	info[:first_name],
			        last_name:  	info[:last_name],
			        linkedin_url:  	info[:urls][:public_profile],
			        image:      	info[:image]
	      		)
				SessionsHelper::MandrillHelper.template a.email
	        end

	        return a
		end

		def self.educations id, educations
			return unless educations
 	    	educations.each do |education|
				e = Education.find_by(applicant_id: id, school: education[:schoolName]) unless education[:startDate]	        	
	        	e = Education.find_by(applicant_id: id, school: education[:schoolName], started_at: education[:startDate][:year]) if education[:startDate]
	          	Education.create(
	            	applicant_id: id,
	            	school:       education[:schoolName],
	            	degree:       education[:degree],
	            	field:        education[:fieldOfStudy],
	            	started_at:   (education[:startDate] ? education[:startDate][:year] : nil),
	            	ended_at:     (education[:endDate] ? education[:endDate][:year] : nil)
	          	) unless e
      		end
		end

		def self.positions id, positions
			return unless positions
      		positions.each do |position|
		        b = Business.find_or_create_by(name: position[:company][:name])
		        p = Position.find_by(applicant_id: id, business_id: b.id, name: position[:title])
		        p = Position.create(
		            applicant_id: id,
		            business_id:  b.id,
		            name:         position[:title],
		            summary:      position[:summary],
		            started_at:   (position[:startDate][:month] ? Date.new(position[:startDate][:year], position[:startDate][:month]) : Date.new(position[:startDate][:year])),
		            ended_at:     (position[:endDate] ?  (position[:endDate][:month] ? Date.new(position[:endDate][:year], position[:endDate][:month]) : Date.new(position[:endDate][:year])) : nil)
		        ) unless p
	      	end
		end
	end

	class GithubHelper
		extend SessionsHelper
		BASE = "https://api.github.com"
		REPOS = '/user/repos'

		def self.repos token, a
			return nil unless token or a
			repos = JSON.parse(get(URI.parse("#{BASE}#{REPOS}?access_token=#{token}")).body)
			return unless repos

			# Get all existing repos in db
			# Delete repo if it does not exist in returned json
			db = Repo.where applicant_id: a.id
			c = false
			db.each do |d| 
				repos.each do |repo|
					c = true if d.name == repo.name
				end

				Repo.destroy d.id unless c
				c = false
			end

			# Update user repos in db
	    	repos.each do |repo|
		        repo.symbolize_keys!

		        r = Repo.find_by name: repo[:name], applicant_id: a.id
		        r = Repo.create(
		          applicant_id: a.id,
		          name:         repo[:name],
		          full_name:    repo[:full_name],
		          url:          repo[:html_url],
		          started_at:   Date.parse(repo[:created_at]),
		          updated_at:   Date.parse(repo[:updated_at])
		        ) unless r

		        yield r
    		end
  		end

	  	def self.languages token, r
			return nil unless name or full_name or token
			languages = JSON.parse(get(URI.parse("#{BASE}/repos/#{r.full_name}/languages?access_token=#{token}")).body)
        	languages.symbolize_keys!
	        total = 0

	        # Find total LOC for a repo
	        languages.keys.each do |key|
	          total += languages[key].to_i
	        end

	        languages.keys.each do |key|
	          s = Skill.find_or_create_by name: key
	          Language.find_by(repo_id: r.id, skill_id: s.id) or
	            Language.create(
	              repo_id:  r.id,
	              skill_id: s.id,
	              percent:  ((languages[key].to_f / total) * 100).round(2)
	            )
	        end
	  	end
	end

	class MandrillHelper
		extend SessionsHelper
		RAW = 'https://mandrillapp.com/api/1.0/messages/send-raw.json'
		TEMPLATE = 'https://mandrillapp.com/api/1.0/messages/send-template.json'

		def self.template email
			return nil unless email

			key = Api.find_by provider: 'mandrill', tag: 'client_key'
			uri = URI.parse(TEMPLATE)
			payload = {
			    :key 				=> key.key,
			    :template_name 		=> "Vetrify",
			    :template_content 	=> nil,
			    :message 			=> {
			        :to => [{:email => email}]
			    },
			    :async 				=> false,
			    :ip_pool 			=> "Main Pool"
			}.to_json

			JSON.parse(post(uri, payload).body)
		end

		def self.raw email, body
			return nil unless email || body

			key = Api.find_by provider: 'mandrill', tag: 'client_key'
			uri = URI.parse(RAW)
			payload = {
			    :key 				=> key.key,
			    :raw_message 		=> "From: info@vetrify.com\nTo: #{email}\nSubject: Applicants List\n\n#{body}",
			    :from_email 		=> "info@vetrify.com",
			    :from_name 			=> "Info",
			    :to 				=> [email],
			    :async 				=> false,
			    :ip_pool 			=> "Main Pool",
			    :send_at 			=> "",
			    :return_path_domain => nil
			}.to_json

			JSON.parse(post(uri, payload).body)
		end
	end
end
