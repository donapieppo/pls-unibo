# frozen_string_literal: true

class Booking::BookingComponent < ViewComponent::Base
  def initialize(booking, current_user, short: false)
    @booking = booking
    @current_user = current_user

    @what = @booking.activity

    @general_bookable = @what.bookable? && @what.booking_start && @what.booking_end
    @bookable_by_user = BookingPolicy.new(@current_user, @booking).create?
    @free_seats = @what.free_seats

    @user_this_booking = @current_user ? @what.bookings.where(user_id: @current_user.id).first : nil
    @user_sibling_booking_activity_id = @current_user ? @what.cluster_siblings_booked_activity_ids(@current_user).first : nil
    @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
  end

  def render?
    ! @what.over?
  end
end
