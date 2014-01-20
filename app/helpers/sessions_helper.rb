require 'json'
require 'net/http'
require 'net/https'

module SessionsHelper
	def get uri
	  	begin
			http = Net::HTTP.new(uri.host, uri.port)
			http.read_timeout = 15
			http.use_ssl = true if (uri.scheme == 'https')
			http.start do
				request = Net::HTTP::Get.new uri.request_uri
				return http.request request
			end
		rescue Net::ReadTimeout
			return nil
		end
	end

	class LinkedInHelper
		def self.educations id, educations
 	    	educations.each do |education|
	        	Education.find_by(applicant_id: id, school: education[:schoolName], started_at: education[:startDate][:year]) or
	          	Education.create(          
	            	applicant_id: id, 
	            	school:       education[:schoolName], 
	            	degree:       education[:degree],
	            	field:        education[:fieldOfStudy],
	            	started_at:   education[:startDate][:year],
	            	ended_at:     education[:endDate][:year]
	          	)
      		end
		end

		def self.positions id, positions
      		positions.each do |position|
		        b = Business.find_or_create_by(name: position[:company][:name])
		        p = Position.find_by(applicant_id: id, business_id: b.id, name: position[:title])       
		        p = Position.create(
		            applicant_id: id,
		            business_id:  b.id,
		            name:         position[:title],
		            summary:      position[:summary],
		            started_at:   Date.new(position[:startDate][:year], position[:startDate][:month]),
		            ended_at:     (position[:endDate] ? Date.new(position[:endDate][:year], position[:endDate][:month]) : nil)
		        ) unless p

		        if p.summary != position[:summary] 
		          Position.update(
		            p.id,
		            :summary  =>  position[:summary],
		            :ended_at =>  (position[:endDate] ? Date.new(position[:endDate][:year], position[:endDate][:month]) : nil)
		          )
		        end
	      	end
		end
	end

	class GithubHelper
		extend SessionsHelper
		BASE = "https://api.github.com"
		REPOS = '/user/repos'

		def self.repos token, id
			return nil unless token			
			repos = JSON.parse(get(URI.parse("#{BASE}#{REPOS}?access_token=#{token}")).body)

	      	repos.each do |repo|
		        repo.symbolize_keys!

		        r = Repo.find_by(name: repo[:name])
		        r = Repo.create(          
		          applicant_id: id,
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
end