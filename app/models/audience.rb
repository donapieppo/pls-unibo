class Audience < ApplicationRecord
  # has_many :activities
  has_many :editions

  def to_s
    self.name
  end
end
