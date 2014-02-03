class Applicant < ActiveRecord::Base
  has_many  :positions
  has_many	:businesses, through: :positions

  has_many 	:educations
  has_many	:repos
  has_one   :token

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}".strip
  end
end
