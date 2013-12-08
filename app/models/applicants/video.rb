class Video < ActiveRecord::Base
  belongs_to :profile

  has_and_belongs_to_many :questions
end
