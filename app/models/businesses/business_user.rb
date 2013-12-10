class BusinessUser < ActiveRecord::Base
  belongs_to :business

  has_secure_password

  validates :email, presence: true
  validates :name, presence: true
  validates :password, length: { in: 6..20 }, on: :create
end
