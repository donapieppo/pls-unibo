# frozen_string_literal: true

class Booking::CurrentUserBookingComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user

    if @current_user
      @user_this_booking = @current_user ? @what.bookings.where(user_id: @current_user.id).first : nil

      @user_sibling_booking_activity_id = @current_user ? @what.cluster_siblings_booked_activity_ids(@current_user).first : nil
      @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
    end
  end

  def render?
    @current_user 
  end
end

