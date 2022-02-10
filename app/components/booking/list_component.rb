# frozen_string_literal: true

class Booking::ListComponent < ViewComponent::Base
  def initialize(current_user, teacher: false)
    @current_user = current_user
    @bookings = teacher ? Booking.where(teacher_id: @current_user.id) : Bookings.where(user_id: @current_user.id) 
    @bookings = @bookings.includes(:activity, :user).order(:activity_id)
  end
end


