require 'json'
require 'net/http'
require 'net/https'

module ApplicationHelper
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

	class GithubHelper
		extend ApplicationHelper
		BASE = "https://api.github.com"
		REPOS = '/user/repos'

		def self.repos token
			return nil unless token			
			return JSON.parse(get(URI.parse("#{BASE}#{REPOS}?access_token=#{token}")).body)
	  	end

	  	def self.languages token, name
			return nil unless name or full_name or token	
			return JSON.parse(get(URI.parse("#{BASE}/repos/#{name}/languages?access_token=#{token}")).body)
	  	end
	end
end