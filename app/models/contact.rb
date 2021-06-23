class Contact < ApplicationRecord
  has_many :contact_records
  has_many :organized_areas, foreign_key: "head_id", class_name: 'Area'
  has_and_belongs_to_many :areas
  
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :activities_as_speaker, join_table: 'activities_speakers', class_name: 'Activity'

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :editions
  has_and_belongs_to_many :events

  validates :name, :email, uniqueness: { allow_blank: true }
  validates :web_page, format: { with: URI.regexp(['http', 'https']), allow_blank: true }

  def records 
    self.contacts_records.map(&:record)
  end

  def to_s
    self.name
  end

  def deletable?
    self.activities.empty? && self.organized_areas.empty? && self.activities_as_speaker.empty?
  end
end
