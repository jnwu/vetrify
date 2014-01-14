class Business < ActiveRecord::Base
  	validates :name, presence: true
end
