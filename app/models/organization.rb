class Organization < ApplicationRecord
  has_and_belongs_to_many :areas

  def to_s
    self.name
  end
end
