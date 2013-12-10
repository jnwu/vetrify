class Business < ActiveRecord::Base
	has_many :skillgroups, as: :skillable
	has_many :skills, through: :skillgroups

	has_many :posts

  validates :name, presence: true
end
