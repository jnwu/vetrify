class Profile < ActiveRecord::Base
	has_many :skillgroups, as: :skillable
	has_many :skills, through: :skillgroups

	has_many :videos

  has_and_belongs_to_many :posts

  def name
    "#{first_name} #{last_name}".strip
  end

end
