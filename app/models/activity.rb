class Activity < ApplicationRecord
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :clusters
  has_many :bookings

  before_destroy :check_children

  validates :name, presence: true, allow_blank: false

  scope :bookable_now, -> { where('activities.booking_start is not null and activities.booking_end is not null and activities.booking_start <= NOW() and NOW() <= activities.booking_end') }

  scope :clusterable, -> (year) { where(academic_year: year).order(:name) }
  scope :visible, -> { where.not('activities.hidden = 1') }
  scope :future, -> { where('start_date >= NOW()') }

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end

  def bookable?
    self.bookable && self.bookable != 'no'
  end

  def booking_to_confirm?
    self.bookable && self.bookable == 'to_confirm'
  end

  def now_in_bookable_interval?
    now = Time.now
    self.booking_start && self.booking_end && self.booking_start < now && now < self.booking_end
  end

  # FIXME 
  # unite with scope :bookable_now
  def bookable_now?
    self.bookable? && self.now_in_bookable_interval? && free_seats > 0
  end

  def booked_by?(user)
    self.bookings.where(user_id: user.id).any?
  end

  def cluster_siblings
    self.clusters.map{|c| c.activities}.flatten.uniq
  end

  def free_seats
    @free_seats_cache ||= (self.seats.to_i > 0) ? (self.seats - self.bookings.sum(:seats)) : 0
  end

  def cluster_siblings_booked_activity_ids(user)
    user.bookings.map(&:activity_id) & self.clusters.map(&:activity_ids).flatten
  end

  def any_cluster_siblings_booked?(user)
    cluster_siblings_booked_activity_ids(user).any?
    #self.cluster_siblings.each do |a|
    #  return false if e.booked_by?(user)
    #end
    #true
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
end
