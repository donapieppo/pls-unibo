class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :user_id, uniqueness: { scope: [:activity_id], message: "Prenotazione già presente." }

  scope :by_teacher, -> (u_id) { where(teacher_id: u_id) }
end
