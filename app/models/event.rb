class Event < Activity
  has_and_belongs_to_many :contacts, through: 'activities_contacts', foreign_key: 'activity_id'
  has_and_belongs_to_many :speakers, join_table: 'activities_speakers', foreign_key: 'activity_id', class_name: 'Contact'

  belongs_to :edition, foreign_key: 'parent_id'

  def to_s
    self.name
  end
end
