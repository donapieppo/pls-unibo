module Bookable
  extend ActiveSupport::Concern

  included do
    # has_one :bookability
    has_many :bookings

    scope :with_bookings, -> { where(id: Booking.select(:activity_id).group(:activity_id).map(&:activity_id)) }
    scope :bookable_now, -> { where('activities.booking_start is not null and activities.booking_end is not null and activities.booking_start <= NOW() and NOW() <= activities.booking_end') }
    scope :bookable_undone, -> { where('activities.bookable != "done"') }
  end

  def bookable?
    self.bookable && self.bookable != 'no' && self.booking_start && self.booking_end
  end

  def external_booking?
    self.bookable && self.bookable == 'external'
  end

  def booking_to_confirm?
    self.bookable && self.bookable == 'to_confirm'
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

  def bookable_by_user?(_user)
    return false if self.external_booking?
    return false unless _user
    case self.bookable_by
    when 'all'
      true
    when 'student_secondary'
      _user.student_secondary?
    when 'student_university'
      _user.student_university?
    when 'teacher'
      _user.teacher?
    end
  end

  def bookable_by_description
    case self.bookable_by
    when 'student_secondary'
      'prenotazioni aperte agli studenti delle scuole secondarie'
    when 'student_university'
      'prenotazioni aperte agli studenti universitari'
    when 'teacher'
      case self.bookable_for
      when 'itsself'
        'prenotazioni aperte ai docenti'
      when 'classes'
        'prenotazioni aperte a classi di studenti iscritti dal docente'
      when 'students'
        'prenotazioni aperte a studenti iscritti dal docente'
      end
    else
      ''
    end
  end

  def booked_by?(user)
    self.bookings.where(user_id: user.id).any?
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

  def free_seats
    @free_seats_cache ||= (self.seats.to_i > 0) ? (self.seats - self.bookings.sum(:seats)) : 0
  end
end
