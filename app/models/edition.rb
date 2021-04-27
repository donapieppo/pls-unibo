class Edition < Activity
  has_and_belongs_to_many :contacts, join_table: 'activities_contacts', foreign_key: 'activity_id'
  has_and_belongs_to_many :speakers, join_table: 'activities_speakers', foreign_key: 'activity_id', class_name: 'Contact'

  has_rich_text :details

  belongs_to :project, foreign_key: 'parent_id'
  has_many :events, foreign_key: 'parent_id'

  belongs_to :audience

  validates :academic_year, presence: true

  def to_s
    self.name
  end
end
