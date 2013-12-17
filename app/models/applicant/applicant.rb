class Applicant < ActiveRecord::Base
	has_many :skillgroups, as: :skillable
	has_many :skills, through: :skillgroups

	has_many :videos

  has_and_belongs_to_many :posts

  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  def name
    "#{first_name} #{last_name}".strip
  end
end
