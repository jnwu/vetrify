class Applicant < ActiveRecord::Base
  has_many  :positions
  has_many	:businesses, through: :positions

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}".strip
  end
end
