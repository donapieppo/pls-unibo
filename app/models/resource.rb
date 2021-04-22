class Resource < ApplicationRecord
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :activities
  has_many :resource_items

  validates :name, uniqueness: true

  def to_s
    self.name
  end

  def areas_to_s
    self.areas.map(&:name).join(', ')
  end
end
