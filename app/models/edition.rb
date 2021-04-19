class Edition < Activity
  has_and_belongs_to_many :contacts, join_table: 'activities_contacts', foreign_key: 'activity_id'

  belongs_to :project, foreign_key: 'parent_id'
  has_many :events, foreign_key: 'parent_id'

  belongs_to :audience

  validates :name, uniqueness: true, presence: true
  validates :academic_year, presence: true

  def to_s
    self.name
  end
end
