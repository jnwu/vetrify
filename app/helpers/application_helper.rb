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
				request = Net::HTTP::Get.new(uri.request_uri)
				return http.request(request)
			end
		rescue Net::ReadTimeout
			return nil
		end
	end

	class GithubHelper
		extend ApplicationHelper

		def self.pull token
			return nil unless(field or token)
			uri = URI.parse("https://api.github.com/user/repos?access_token=#{token}")
			return get uri
	  	end
	end
end