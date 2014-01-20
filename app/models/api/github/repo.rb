class Repo < ActiveRecord::Base
	belongs_to :applicant

	has_many :languages
  	has_many :skills, through: :languages
end
