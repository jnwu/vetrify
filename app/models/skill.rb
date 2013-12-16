class Skill < ActiveRecord::Base
	has_many :skillables
	has_many :skillables, through: :skillgroups
end
