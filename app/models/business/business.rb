class Business < ActiveRecord::Base
  	has_many :positions
  	has_many :applicants, through: :positions

	validates :name, presence: true
end
