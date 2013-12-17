class Question < ActiveRecord::Base
  belongs_to :post

  has_and_belongs_to_many :videos
end
