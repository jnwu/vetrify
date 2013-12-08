class Skillgroup < ActiveRecord::Base
  belongs_to :skillable, polymorphic: true
  belongs_to :skill

  has_and_belongs_to_many :sources
end
