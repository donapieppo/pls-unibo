class Project < Activity
  has_and_belongs_to_many :areas,            join_table: 'activities_areas',    foreign_key: 'activity_id'
  has_and_belongs_to_many :interested_areas, join_table: 'areas_interests',     foreign_key: 'activity_id', class_name: 'Area'
  has_and_belongs_to_many :contacts,         join_table: 'activities_contacts', foreign_key: 'activity_id'
  belongs_to :organization, optional: true

  has_rich_text :details

  has_many :editions, foreign_key: 'parent_id'        # parent_id is in editions
  belongs_to :activity_type, foreign_key: 'parent_id' # parent_id is here

  validates :name, uniqueness: {}

  before_save :global_and_areas_relation
  # FIXME 
  # manca uniq alla fine
  scope :this_academic_year, -> { joins("JOIN `activities` `editions_activities` ON `editions_activities`.`parent_id` = `activities`.`id` AND `editions_activities`.`type` = 'Edition' AND (editions_activities.academic_year = #{CURRENT_ACADEMIC_YEAR})") }

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

  def current_year?
    self.cache_years.last >= CURRENT_ACADEMIC_YEAR
  end

  def cache_years
    if @_cache_years 
      @_cache_years
    else
      @_cache_years = self.editions.order(:academic_year).map(&:academic_year)
    end
  end

  def editions_audience_ids
    self.editions.map(&:audience_id)
  end
end
