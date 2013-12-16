class Video < ActiveRecord::Base
  belongs_to :applicant

  has_and_belongs_to_many :questions
end
