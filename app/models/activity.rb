class Activity < ApplicationRecord
  include Bookable 

  has_and_belongs_to_many :resources
  has_and_belongs_to_many :clusters

  has_many :snippets

  before_destroy :check_children

  validates :name, presence: true, allow_blank: false

  scope :in_current_academic_year, -> { where(academic_year: CURRENT_ACADEMIC_YEAR) }
  scope :visible, -> (nolimit) { where.not('activities.hidden = 1') unless nolimit }
  scope :future, -> { where('activities.start_date > DATE_ADD(UTC_TIMESTAMP(), INTERVAL -2 hour)') }
  scope :past, -> { where('activities.start_date <= DATE_ADD(UTC_TIMESTAMP(), INTERVAL -2 hour)') }

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end

  def cluster_siblings
    self.clusters.map { |c| c.activities }.flatten.uniq
  end

  def self.approximate_count
    @@approximate_count ||= Activity.count.round(-1)
  end

  def visible?
    ! self.hidden
  end

  def on_and_off_line?
    self.online && self.in_presence
  end

  def on_zoom?
    self.access_url =~ /zoom/
  end

  def on_teams?
    self.access_url =~ /teams.microsoft.com/
  end

  def access_url_name
    if on_zoom?
      "Stanza zoom"
    elsif on_teams?
      "Stanza Teams"
    else
      self.access_url
    end
  end

  def speakers_to_s(if_blank: '')
    res = self.speakers.map { |speaker| speaker.to_s }.join(', ')
    res.blank? ? if_blank : res
  end

  def this_academic_year?
    self.academic_year == CURRENT_ACADEMIC_YEAR
  end
end
