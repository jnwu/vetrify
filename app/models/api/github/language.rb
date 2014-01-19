class Language < ActiveRecord::Base
  belongs_to :repo
  belongs_to :skill
end
