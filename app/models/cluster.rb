class Cluster < ApplicationRecord
  # SONO EDITIONS
  has_and_belongs_to_many :activities

  has_rich_text :details

  validates :name, uniqueness: true

  def to_s
    self.name
  end

  def max_bookable_activities_to_s
    if max_bookable_activities.to_i == 1
      "È possibile iscriversi a una sola delle attività."
    elsif max_bookable_activities.to_i > 1
      "È possibile iscriversi a non più di #{max_bookable_activities.to_i} attività."
    end
  end
end
