require 'csv'

class BookingSeatsValidator < ActiveModel::Validator
  def validate(record)
    activity = record.activity
    if activity.seats.to_i > 0 && record.seats.to_i > activity.free_seats
      record.errors.add :seats, "Non ci sono sufficienti posti da prenotare."
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :school

  validates :user_id, uniqueness: { scope: [:activity_id], message: "Prenotazione già presente." }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail non corretto" }

  validates :teacher_name, :teacher_surname, presence: { allow_blank: false }, if: -> { user.student? }
  validates :teacher_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail del docente non corretto" }, if: -> { user.student? }

  validates :name, :surname, presence: { allow_blank: false }
  validates_with BookingSeatsValidator 

  scope :by_teacher, -> (u_id) { where(teacher_id: u_id) }
  scope :in_presence, -> { where(online: false) }
  scope :online, -> { where(online: true) }

  before_validation :copy_params_from_user,
                    :confirm_if_activity_not_to_confirm
  after_create :create_nonce

  def copy_params_from_user
    # if self.user_id && ! self.user
    #   self.user = User.find(self.user_id)
    # end
    if u = self.user 
      self.email = u.email
      self.name = u.name
      self.surname = u.surname
      self.role = u.role
      self.school_type = u.school_type
      self.school = u.school
      self.other_string = u.other_string
      self.school_pec = u.school_pec
      self.school_city = u.school_city
    end
  end

  def confirm_if_activity_not_to_confirm
    self.confirmed = ! self.activity.booking_to_confirm?
  end

  def confirmed?
    !! self.confirmed
  end

  def confirm
    self.confirmed = true
    self.save!
  end

  def self.to_csv(_activity)
    CSV.generate(headers: true) do |csv|
      csv << ['posto', 'nome', 'online', 'ruolo', 'scuola_id', 'scuola', 'email']
      _activity.bookings.each do |b|
        csv << [b.seats, b.user.cn_militar, b.online ? 'online' : '', b.role, b.school_id, b.school, b.user.email]
      end
    end
  end

  def missing_user_data?
    user = self.user
    if user.role.blank? || user.name.blank? || user.surname.blank?
      return true
    end
    if user.student?
      if user.school_id.blank? || user.school_city.blank? || user.school_pec.blank?
        return true
      end
    end
    false
  end

  private 

  def create_nonce
    loop do
      n = rand(10001..99999)
      if ! Booking.find_by nonce: n
        self.nonce = n
        self.save
        break
      end
    end
  end
end

