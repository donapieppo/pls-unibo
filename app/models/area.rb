class Area < ApplicationRecord
  has_and_belongs_to_many :organizations
  belongs_to :contact, foreign_key: "head_id"

  has_and_belongs_to_many :projects, through: 'activities_areas', association_foreign_key: 'activity_id'
  has_and_belongs_to_many :interesting_projects, through: 'areas_interests', association_foreign_key: 'activity_id', class_name: 'Project'

  has_and_belongs_to_many :products

  def to_s
    self.name
  end
end
