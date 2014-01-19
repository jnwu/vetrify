class Repo < ActiveRecord::Base
  has_many :languages
  has_many :skills, through: :languages
end
