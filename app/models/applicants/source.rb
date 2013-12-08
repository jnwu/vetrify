class Source < ActiveRecord::Base
  has_and_belongs_to_many :skillgroups
end
