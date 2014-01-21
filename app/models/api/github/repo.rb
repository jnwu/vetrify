class Repo < ActiveRecord::Base
	belongs_to :applicant

	has_many :languages
	has_many :skills, through: :languages

  # TODO move to decorator
  def pretty_date
    "#{started_at.strftime("%B %Y")} - #{updated_at.strftime("%B %Y")}"
  end
end
