module Bookable
  extend ActiveSupport::Concern

  included do
    # has_one :bookability
    has_many :bookings

    scope :with_bookings, -> { where(id: Booking.select(:activity_id).group(:activity_id).map(&:activity_id)) }
    scope :bookable_now, -> { where('activities.booking_start is not null and activities.booking_end is not null and activities.booking_start <= NOW() and NOW() <= activities.booking_end') }
    scope :bookable_undone, -> { where('activities.bookable != "done"') }

    before_save :fix_dates_for_external
  end

  def external_booking?
    self.bookable && self.bookable == 'external'
  end

  def booking_to_confirm?
    self.bookable && self.bookable == 'to_confirm'
  end

  def now_in_bookable_interval?
    now = Time.now
    self.booking_start && self.booking_end && self.booking_start < now && now < self.booking_end
  end

  def bookable_by_user?(_user)
    return false unless _user

    if self.external_booking?
      return false
    elsif self.bookable_for_itsself?(_user)
      return true
    elsif self.bookable_for_students?(_user) || self.bookable_for_classes?(_user)
      return true
    else
      return false
    end
  end

  def bookable_for_itsself?(_user)
    return false unless _user

    if self.bookable_by_all
      return true
    elsif self.bookable_by_student_secondary && _user.student_secondary?
      return true
    elsif self.bookable_by_student_university && _user.student_university?
      return true
    elsif self.bookable_by_teacher && _user.confirmed_teacher?
      return true
    else
      return false
    end
  end

  def bookable_for_students?(_user)
    _user && self.bookable_by_teacher_for_students && _user.confirmed_teacher?
  end

  def bookable_for_classes?(_user)
    _user && self.bookable_by_teacher_for_classes && _user.confirmed_teacher?
  end

  def bookable_by_description
    res = []
    if self.bookable_by_all
      res << ' a tutti'
    end
    if self.bookable_by_student_secondary
      res << ' agli studenti delle scuole secondarie'
    end
    if self.bookable_by_student_university
      res << ' agli studenti universitari'
    end
    if self.bookable_by_teacher
      res << ' ai docenti'
    end
    if self.bookable_by_teacher_for_students
      res << ' a studenti iscritti dal docente'
    end
    if self.bookable_by_teacher_for_classes
      res << ' a classi di studenti iscritti dal docente'
    end

    if res.any?
      return 'Prenotazione aperta ' + res.to_sentence
    else
      return ''
    end
  end

  def booked_by?(user)
    self.bookings.where(user_id: user.id).where(school_class: nil).any?
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
    @free_seats_cache ||= (self.seats.to_i > 0) ? (self.seats - self.bookings.in_presence.sum(:seats)) : 0
  end

  def fix_dates_for_external
    if self.external_booking?
      self.booking_start = nil
      self.booking_end = nil
    end
  end
end
