require "csv"

class BookingUserRolePresenceValidator < ActiveModel::Validator
  def validate(record)
    record.user.role or record.errors.add :base, "Manca il ruolo del'utente"
  end
end

class BookingSchoolForSecondaryValidator < ActiveModel::Validator
  def validate(record)
    if record.user.student_secondary? || record.user.teacher?
      record.user.school or record.errors.add :school_id, "Manca la scuola"
    end
  end
end

class BookingSingleValidator < ActiveModel::Validator
  def validate(record)
    return true if record.school_class
    return true if record.teacher_id
    user = record.user
    others = user.bookings.where(activity_id: record.activity_id).where(school_class: nil).count
    if others > 0
      record.errors.add :base, "Già prenotato questa attività."
    end
  end
end

class BookingLimitInClusterValidator < ActiveModel::Validator
  def validate(record)
    if record.activity.cluster_complete_for_user?(record.user)
      record.errors.add :base, "Già prenotato attività in questo raggruppamento."
    end
  end
end

class BookingOnLineOrPresence < ActiveModel::Validator
  def validate(record)
    if record.online && !record.activity.online
      record.errors.add :base, :not_online, message: "Non è possibile prenotare in remoto questa attività."
    end
    if !record.online && !record.activity.in_presence
      record.errors.add :base, :not_in_presence, message: "Non è possibile prenotare in presenza questa attività."
    end
  end
end

class BookingSeatsValidator < ActiveModel::Validator
  def validate(record)
    return true if record.online
    if record.seats.to_i > record.activity.free_seats
      record.errors.add :seats, "Non ci sono sufficienti posti da prenotare."
    end
    if record.activity.bookable_by_teacher_for_groups && record.for_group? && record.seats.to_i > record.activity.bookable_group_limit
      record.errors.add :seats, "Non è possibile prenotare più di #{record.activity.bookable_group_limit} posti."
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :school, optional: true

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail non corretto"}

  validates :teacher_name, :teacher_surname, presence: {allow_blank: false}, if: -> { user.student_secondary? }
  validates :teacher_email, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail del docente non corretto"}, if: -> { user.student_secondary? }

  validates :name, :surname, presence: {allow_blank: false}
  validates_with BookingUserRolePresenceValidator
  validates_with BookingSchoolForSecondaryValidator
  validates_with BookingSingleValidator
  validates_with BookingOnLineOrPresence
  validates_with BookingSeatsValidator
  validates_with BookingLimitInClusterValidator

  scope :by_teacher, ->(u_id) { where(teacher_id: u_id) }
  scope :in_presence, -> { where(online: false) }
  scope :online, -> { where(online: true) }
  scope :personal, -> { where(school_class: nil).where(school_group: false) }

  before_validation :fix_seats_online,
    :copy_params_from_user,
    :manage_class_booking,
    :confirm_if_activity_not_to_confirm
  after_create :create_nonce

  # FIXME
  def teacher
    User.find(self.teacher_id)
  end

  def confirmed?
    !!self.confirmed
  end

  def confirm
    self.confirmed = true
    self.save!(validate: false)
  end

  def for_class?
    !self.school_class.blank?
  end

  def for_group?
    self.school_group
  end

  def self.to_csv(bs)
    CSV.generate(headers: true, encoding: Encoding::UTF_8) do |csv|
      csv << [
        "posto",
        "nome",
        "cognome",
        "online",
        "ruolo",
        "scuola_id",
        "scuola",
        "classe",
        "pec scuola",
        "email",
        "nome docente",
        "email docente",
        "attività",
        "notes"
      ]
      bs.each do |b|
        csv << [
          b.seats,
          b.user.name.strip,
          b.user.surname.strip,
          b.online ? "online" : "",
          b.role,
          b.school_id,
          b.school,
          b.grade,
          b.school_pec,
          b.user.email.strip,
          (b.teacher_name.blank? ? "" : (b.teacher_name.strip + " " + b.teacher_surname.strip)),
          (b.teacher_email.blank? ? "" : b.teacher_email.strip),
          b.activity,
          b.notes
        ]
      end
    end
  end

  def missing_data?(what)
    user = (what == :user) ? self.user : self.teacher
    if user.role.blank? || user.name.blank? || user.surname.blank?
      logger.info("booking missing data role name surname")
      return true
    end
    if user.student_secondary?
      unless user.school
        logger.info("booking missing data student_secondary")
        return true
      end
    end
    false
  end

  def seats_to_s
    return unless self.seats.to_i > 0
    "#{self.seats} post" + ((self.seats > 1) ? "i" : "o")
  end

  def typology_to_s
    self.confirmed ? "iscrizione" : "prenotazione da confermare"
  end

  private

  def create_nonce
    loop do
      n = rand(10001..99999)
      if !Booking.find_by nonce: n
        self.nonce = n
        self.save
        break
      end
    end
  end

  def fix_seats_online
    if self.online
      self.seats = 0
    elsif self.seats.to_i == 0
      self.seats = 1
    end
  end

  def copy_params_from_user
    # if self.user_id && ! self.user
    #   self.user = User.find(self.user_id)
    # end
    if (u = self.user)
      self.email = u.email
      self.name = u.name
      self.surname = u.surname
      self.role = u.role
      self.school = u.school
      self.other_string = u.other_string
      if u.school
        self.school_pec = u.school_pec
        self.school_city = "#{u.school.municipality} - #{u.school.province}"
      end
    end
  end

  def confirm_if_activity_not_to_confirm
    self.confirmed = !self.activity.booking_to_confirm?
  end

  def manage_class_booking
    self.teacher_id = self.user_id if self.school_class
    self.school_class = nil if self.school_class.blank?
  end
end
