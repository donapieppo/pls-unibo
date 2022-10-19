# frozen_string_literal: true

class Bookability::ActionsComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    @free_seats = @what.free_seats.to_i

    # con start e end date e interno (non 'no' e non external)
    if render?
      booking_online = what.bookings.new(online: true)
      booking_inpresence = what.bookings.new(online: false)

      @bookable_by_user_online = BookingPolicy.new(@current_user, booking_online).create? 
      @bookable_by_user_inpresence = BookingPolicy.new(@current_user, booking_inpresence).create?

      @bookable_by_user = @bookable_by_user_online || @bookable_by_user_inpresence

      @bookable_for_itsself = @bookable_by_user && @what.bookable_for_itsself?(@current_user)
      @bookable_for_students = @bookable_by_user && @what.bookable_for_students?(@current_user)
      @bookable_for_classes = @free_seats > 0 && @bookable_by_user && @what.bookable_for_classes?(@current_user)

      if @bookable_for_itsself 
        @user_this_booking = @what.bookings.where(user_id: @current_user.id).where(school_class: nil).first 
        @user_sibling_booking_activity_id = @what.cluster_siblings_booked_activity_ids(@current_user).first 
        @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
      end
    end
  end

  def render?
    @current_user && @what.internally_bookable_with_dates?
  end
end
