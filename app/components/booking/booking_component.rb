# frozen_string_literal: true

class Booking::BookingComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user

    unless @what.unbookable?
      @booking = what.bookings.new

      @bookable_by_user = BookingPolicy.new(@current_user, @booking).create?
      @free_seats = @what.free_seats

      if @bookable_for_itsself = (@what.bookable_for == 'itsself')
        @user_this_booking = @current_user ? @what.bookings.where(user_id: @current_user.id).first : nil
        @user_sibling_booking_activity_id = @current_user ? @what.cluster_siblings_booked_activity_ids(@current_user).first : nil
        @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
      elsif @bookable_by_teacher_for_students = (@current_user && @current_user.teacher? && what.bookable_by == 'teacher' && @what.bookable_for == 'students')
        # ok
      else
        # future
      end
    end
  end

  def render?
    ! @what.unbookable?
  end
end
