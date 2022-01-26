# frozen_string_literal: true

class Booking::TeacherBookingsComponent < ViewComponent::Base
  def initialize(teacher_email, current_user)
    @teacher_email = teacher_email
    @bookings = Booking.where(teacher_email: @teacher_email).includes(:user, :activity)
    @current_user = current_user
  end
end
