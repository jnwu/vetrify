class Position < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :business
end
