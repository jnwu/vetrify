class BusinessUser < ActiveRecord::Base
  validates :email, email: true
end
