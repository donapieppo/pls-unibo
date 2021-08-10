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

  def self.on_going_ids
    ActiveRecord::Base.connection.execute("select a1.id, MIN(a2.start_date) as min , MAX(a2.start_date) as max from activities as a1 left join activities as a2 on a1.id = a2.parent_id where a1.type='Edition' and a2.type='Event' group by a2.parent_id having min < NOW() and max > NOW()").map(&:first)
  end

  def self.on_going_project_ids
    ActiveRecord::Base.connection.execute("select a1.parent_id, MIN(a2.start_date) as min , MAX(a2.start_date) as max from activities as a1 left join activities as a2 on a1.id = a2.parent_id where a1.type='Edition' and a2.type='Event' group by a2.parent_id having min < NOW() and max > NOW()").map(&:first)
  end

  def self.bookable_project_ids
    from_events = ActiveRecord::Base.connection.execute("select distinct(a1.parent_id) from activities as a1 left join activities as a2 on a1.id = a2.parent_id where a1.type='Edition' and a2.type='Event' and a2.bookable != 'no' and a2.booking_start < NOW() and a2.booking_end > NOW()").map(&:first)
    from_edition = ActiveRecord::Base.connection.execute("select distinct(parent_id) from activities where type='Edition' and bookable != 'no' and booking_start < NOW() and booking_end > NOW()").map(&:first)
    (from_events + from_edition).uniq
  end
end
