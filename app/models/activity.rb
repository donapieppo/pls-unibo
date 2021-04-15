class Activity < ApplicationRecord
  include ContactRecordMap

  has_many :editions
  belongs_to :audience
  belongs_to :activity_type
  has_and_belongs_to_many :areas

  validates :name, uniqueness: {}

  before_save :global_and_areas_relation

  def global_and_areas_relation
    if self.global
      self.areas = []
    end
  end

  def to_s
    self.name
  end

  def areas_to_s
    if self.global
      'tutte le aree'
    else
      self.areas.map(&:name).join(', ') 
    end
  end
end
