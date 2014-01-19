class Skill < ActiveRecord::Base
  has_many :languages
  has_many :repos, through: :languages	
end
