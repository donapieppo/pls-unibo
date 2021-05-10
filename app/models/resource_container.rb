class ResourceContainer < ApplicationRecord
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :resources

  validates :name, presence: true, allow_blank: false

  def to_s
    self.name
  end

  def areas_to_s
    self.areas.map(&:name).join(', ')
  end
end
