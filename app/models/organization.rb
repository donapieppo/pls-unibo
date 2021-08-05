class Organization < ApplicationRecord
  has_and_belongs_to_many :areas
  has_many :projects

  def to_s
    self.name
  end
end
