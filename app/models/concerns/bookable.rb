class ActivityDatesValidator < ActiveModel::Validator
  def validate(record)
    if record.bookable && (record.bookable == "no" || record.bookable == "to_confirm")
      if record.booking_start && record.booking_end && record.booking_start > record.booking_end
        record.errors.add :booking_start, :wrong_date_order, message: "La data di inizio non può essere successiva alla data di fine."
      end
    end
  end
end

# to be included in activity
module Bookable
  extend ActiveSupport::Concern

  included do
    # has_one :bookability
    has_many :bookings

    scope :with_bookings, -> { where(id: Booking.select(:activity_id).group(:activity_id).map(&:activity_id)) }
    scope :bookable_now, -> { where("activities.booking_start is not null and activities.booking_end is not null and activities.booking_start <= NOW() and NOW() <= activities.booking_end") }
    scope :bookable_undone, -> { where('activities.bookable != "done"') }

    before_save :fix_dates_for_external
    validates_with ActivityDatesValidator
  end

  def with_booking_dates?
    self.booking_start && self.booking_end
  end

  def external_booking?
    self.bookable && self.bookable == "external"
  end

  def booking_to_confirm?
    self.bookable && self.bookable == "to_confirm"
  end

  def internally_bookable_with_dates?
    self.bookable && self.bookable != "no" && self.bookable != "external" && self.with_booking_dates?
  end

  def booking_action_to_s
    return "" unless self.bookable
    self.booking_to_confirm? ? "prenota" : "iscriviti"
  end

  def booking_action_your_students_to_s
    return "" unless self.bookable
    self.booking_to_confirm? ? "prenota i tuoi studenti" : "iscrivi i tuoi studenti"
  end

  def booking_action_class_to_s
    return "" unless self.bookable
    self.booking_to_confirm? ? "prenota una classe di studenti" : "iscrivi una classe di studenti"
  end

  def booking_action_group_to_s
    return "" unless self.bookable
    self.booking_to_confirm? ? "prenota un gruppo di studenti" : "iscrivi un gruppo di studenti"
  end

  # def booking_type_to_s
  #   self.booking_to_confirm? ? "prenotazione" : "iscrizione i tuoi studenti"
  # end

  def now_in_bookable_interval?
    now = Time.now
    self.booking_start && self.booking_end && self.booking_start < now && now < self.booking_end
  end

  # each activity belongs to many clusters each with limited bookable activities number
  # clustr has max_bookable_activities
  def cluster_complete_for_user?(u)
    self.clusters.each do |c|
      if c.max_bookable_activities.to_i > 0
        other_activities_booked_in_cluster = u.bookings.where(activity_id: c.activity_ids).count
        if other_activities_booked_in_cluster >= c.max_bookable_activities.to_i
          return true
        end
      end
    end
    false
  end

  def bookable_for_itsself?(u)
    return false if self.external_booking?
    return false unless u

    if self.bookable_by_all
      return true
    elsif self.bookable_by_student_secondary && u.student_secondary?
      return true
    elsif self.bookable_by_student_university && u.student_university?
      return true
    elsif self.bookable_by_teacher && u.confirmed_teacher?
      return true
    end

    false
  end

  def bookable_for_students?(u)
    return false if self.external_booking?
    u&.confirmed_teacher? && self.bookable_by_teacher_for_students
  end

  def bookable_for_classes?(u)
    return false if self.external_booking?
    u&.confirmed_teacher? && self.bookable_by_teacher_for_classes
  end

  def bookable_for_groups?(u)
    return false if self.external_booking?
    u&.confirmed_teacher? && self.bookable_by_teacher_for_groups
  end

  def bookable_by_user_role?(u)
    return false if self.external_booking?
    return false unless u

    bookable_for_itsself?(u) || bookable_for_students?(u) || bookable_for_classes?(u) || bookable_for_groups?(u)
  end

  def bookable_by_to_s
    res = []
    if self.bookable_by_all
      res << " a tutti"
    end
    if self.bookable_by_student_secondary
      res << " agli studenti delle scuole secondarie"
    end
    if self.bookable_by_student_university
      res << " agli studenti universitari"
    end
    if self.bookable_by_teacher
      res << " ai docenti"
    end
    if self.bookable_by_teacher_for_students
      res << " a studenti iscritti dal docente"
    end
    if self.bookable_by_teacher_for_classes
      res << " a classi di studenti iscritti dal docente"
    end
    if self.bookable_by_teacher_for_groups
      res << " a gruppi di studenti iscritti dal docente"
    end

    what = booking_to_confirm? ? "Prenotazioni" : "Iscrizioni"

    if res.any?
      "#{what} aperte #{res.to_sentence}"
    else
      ""
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
  end

  # booking seats = 0 in online
  def free_seats
    @free_seats_cache ||= (self.seats.to_i > 0) ? (self.seats - self.bookings.sum(:seats)) : 0
  end

  def fix_dates_for_external
    if self.external_booking?
      self.booking_start = nil
      self.booking_end = nil
    end
  end

  def to_book_to_s
    booking_to_confirm? ? "Prenota" : "Iscrivi"
  end
end
