class Activity < ApplicationRecord
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :clusters
  has_many :bookings

  before_destroy :check_children

  validates :name, presence: true, allow_blank: false

  scope :bookable_now, -> { where('activities.booking_start is not null and activities.booking_end is not null and activities.booking_start < NOW() and NOW() < activities.booking_end') }

  # scope :clusterable, -> { where(academic_year: 2021).order(:name) }
  scope :clusterable, -> { order(:name) }

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

  def bookable_now?
    now = Time.now
    self.bookable? && self.booking_start && self.booking_end && self.booking_start < now && now < self.booking_end
  end

  def booked_by?(user)
    self.bookings.where(user_id: user.id).any?
  end

  def cluster_siblings
    self.clusters.map{|c| c.activities}.flatten.uniq
  end

  def free_seats
    if self.seats.to_i > 0
      self.seats - self.bookings.sum(:seats)
    end
  end

  def any_cluster_siblings_booked?(user)
    (user.bookings.map(&:activity_id) & self.clusters.map(&:activity_ids).flatten).any?

    #self.cluster_siblings.each do |a|
    #  return false if e.booked_by?(user)
    #end
    #true
  end

  def self.approximate_count
    @@approximate_count ||= Activity.count.round(-1)
  end
end
