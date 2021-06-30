class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :user_id, uniqueness: { scope: [:activity_id], message: "Prenotazione già presente." }

  scope :by_teacher, -> (u_id) { where(teacher_id: u_id) }

  before_create :copy_params_from_user

  def copy_params_from_user
    if u = self.user
      self.email = u.email
      self.name = u.name
      self.surname = u.surname
      self.role = u.role
      self.school_type = u.school_type
      self.other_string = u.other_string
    end
  end
end
