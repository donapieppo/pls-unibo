# frozen_string_literal: true

class Booking::CurrentUserBookingComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user

    if @current_user
      @user_this_booking = @what.bookings.where(user_id: @current_user.id).personal.first

      @user_sibling_booking_activities = Activity.find(@what.cluster_siblings_booked_activity_ids(@current_user))
    end

    if @current_user&.confirmed_teacher?
      @user_this_teacher_bookings = @what.bookings.where("teacher_id = ? AND school_group > 0", @current_user.id)
    end
  end

  def render?
    @current_user
  end
end
