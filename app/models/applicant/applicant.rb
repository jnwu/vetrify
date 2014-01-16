class Applicant < ActiveRecord::Base
#  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
#  validates :password, length: { in: 6..20 }, on: :create

  def name
    "#{first_name} #{last_name}".strip
  end
end
