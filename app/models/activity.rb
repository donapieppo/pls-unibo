class Activity < ApplicationRecord
  has_and_belongs_to_many :resources
  has_many :bookings

  before_destroy :check_children

  validates :name, presence: true, allow_blank: false

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end

  def bookable_now?
    now = Time.now
    self.bookable && self.booking_start && self.booking_end && self.booking_start < now && now < self.booking_end
  end

  def booked_by?(user)
    self.bookings.where(user_id: user.id).any?
  end
end
