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
  validates :name, :surname, presence: { allow_blank: false }
  validates_with BookingSeatsValidator 

  scope :by_teacher, -> (u_id) { where(teacher_id: u_id) }
  scope :in_presence, -> { where(online: false) }
  scope :online, -> { where(online: true) }

  before_create :copy_params_from_user,
                :confirm_if_activity_not_to_confirm
  after_create :create_nonce

  def copy_params_from_user
    if u = self.user
      self.email = u.email
      self.name = u.name
      self.surname = u.surname
      self.role = u.role
      self.school_type = u.school_type
      self.school = u.school
      self.other_string = u.other_string
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

