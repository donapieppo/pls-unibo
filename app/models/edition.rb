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

  def academic_year_to_s
    "a.a. #{self.academic_year}/#{self.academic_year + 1}"
  end

  def self.all_academic_years
    @@all_academic_years ||= Edition.select(:academic_year).order(academic_year: :desc).group(:academic_year).map(&:academic_year)
  end
end
