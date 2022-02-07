# frozen_string_literal: true

class Booking::CurrentTeacherBookingComponent < ViewComponent::Base
  def initialize(what, current_user, short: false)
    @what = what
    @current_user = current_user
    @current_user_teacher = @current_user.teacher?

    if @current_user_teacher
      @bookings = @what.bookings.where(teacher_id: current_user.id)
    end
  end

  def render?
    @current_user_teacher
  end
end


