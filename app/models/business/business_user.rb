class BusinessUser < ActiveRecord::Base
  belongs_to :business

  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 6..20 }, on: :create
end
