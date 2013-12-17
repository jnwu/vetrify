class Post < ActiveRecord::Base
  	belongs_to :business

	has_many :skillgroups, as: :skillable
	has_many :skills, through: :skillgroups

  	has_many :questions

  	has_and_belongs_to_many :applicants
end
