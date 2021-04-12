class ActivityType < ApplicationRecord
  has_many :activities

  def to_s
    self.name
  end
end
