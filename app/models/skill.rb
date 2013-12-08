class Skill < ActiveRecord::Base
	has_many :profiles
	has_many :profiles, through: :skillgroups
end
