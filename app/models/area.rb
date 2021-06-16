class Area < ApplicationRecord
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :resource_containers
  has_and_belongs_to_many :contacts
  belongs_to :head, foreign_key: "head_id", class_name: 'Contact'

  has_and_belongs_to_many :projects, through: 'activities_areas', association_foreign_key: 'activity_id'
  has_and_belongs_to_many :interesting_projects, through: 'areas_interests', association_foreign_key: 'activity_id', class_name: 'Project'

  # has_and_belongs_to_many :products

  def to_s
    self.name
  end
end
