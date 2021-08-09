class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  belongs_to :school

  validates :user_id, uniqueness: { scope: [:activity_id], message: "Prenotazione già presente." }

  scope :by_teacher, -> (u_id) { where(teacher_id: u_id) }

  before_create :copy_params_from_user,
                :confirm_if_activity_not_to_confirm

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
end
