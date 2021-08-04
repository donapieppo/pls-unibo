class Project < Activity
  has_and_belongs_to_many :areas,            join_table: 'activities_areas',    foreign_key: 'activity_id'
  has_and_belongs_to_many :interested_areas, join_table: 'areas_interests',     foreign_key: 'activity_id', class_name: 'Area'
  has_and_belongs_to_many :contacts,         join_table: 'activities_contacts', foreign_key: 'activity_id'

  has_rich_text :details

  has_many :editions, foreign_key: 'parent_id'        # parent_id is in editions
  belongs_to :activity_type, foreign_key: 'parent_id' # parent_id is here

  validates :name, uniqueness: {}

  before_save :global_and_areas_relation

  attr_accessor :cache_years

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

  def edition_years
    @cache_years ||= self.editions.order(:academic_year).map(&:academic_year)
  end

  def editions_audience_ids
    self.editions.map(&:audience_id)
  end
end
