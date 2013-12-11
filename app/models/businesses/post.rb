class Post < ActiveRecord::Base
  belongs_to :business

  has_many :questions
  has_many :skills

  has_and_belongs_to_many :profiles
end