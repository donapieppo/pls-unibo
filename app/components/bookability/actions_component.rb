# frozen_string_literal: true

class Bookability::ActionsComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user

    # con start e end date e non 'no'
    if @current_user && @what.bookable?
      @free_seats = what.free_seats
      @booking = what.bookings.new

      @bookable_by_user = BookingPolicy.new(@current_user, @booking).create?

      @bookable_for_itsself = @bookable_by_user && @what.bookable_for_itsself?(@current_user)
      @bookable_for_students = @bookable_by_user && @current_user.confirmed_teacher? && @what.bookable_for_students?(@current_user)
      @bookable_for_classes = @bookable_by_user && @current_user.confirmed_teacher? && @what.bookable_for_classes?(@current_user)

      if @bookable_for_itsself 
        @user_this_booking = @what.bookings.where(user_id: @current_user.id).where(school_class: nil).first 
        @user_sibling_booking_activity_id = @what.cluster_siblings_booked_activity_ids(@current_user).first 
        @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
      end
    end
  end

  def render?
    @what.bookable?
  end
end
