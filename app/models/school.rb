class School < ApplicationRecord
  has_many :users

  def to_s
    self.name
  end
end
