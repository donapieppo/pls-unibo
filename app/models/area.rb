class Area < ApplicationRecord
  has_and_belongs_to_many :activities

  def to_s
    self.name
  end
end
