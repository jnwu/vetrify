class Position < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :business

  # TODO move to decorator
  def type
    return "work"
  end

  # TODO move to decorator
  def pretty_date
    if (ended_at.present?)
      "#{started_at.strftime("%B %Y")} - #{ended_at.strftime("%B %Y")}"
    else
      "#{started_at.strftime("%B %Y")} - Current"
    end
  end
end
