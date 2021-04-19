class Event < Activity
  has_and_belongs_to_many :contacts, through: 'activities_contacts', foreign_key: 'activity_id'
  belongs_to :edition, foreign_key: 'parent_id'

  def to_s
    self.name
  end
end
