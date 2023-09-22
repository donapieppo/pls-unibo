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

      if @current_user
        online_booking_policy = BookingPolicy.new(@current_user, booking_online)
        in_presence_booking_policy = BookingPolicy.new(@current_user, booking_inpresence)

        @bookable_by_user_online = online_booking_policy.create?
        @bookable_for_students_online = online_booking_policy.new_student?

        @bookable_by_user_inpresence = in_presence_booking_policy.create?
        @bookable_for_students_inpresence = in_presence_booking_policy.new_student?
        @bookable_for_classes = in_presence_booking_policy.new_school_class?
        @bookable_for_groups = in_presence_booking_policy.new_school_group?

        if @bookable_by_user_online || @bookable_by_user_inpresence
          @user_this_booking = @what.bookings.where(user_id: @current_user.id).where(school_class: nil).first
          @user_sibling_booking_activity_id = @what.cluster_siblings_booked_activity_ids(@current_user).first
          @user_sibling_booking_activity = Activity.find(@user_sibling_booking_activity_id) if @user_sibling_booking_activity_id
        end
      end
    end
  end

  def render?
    @what.internally_bookable_with_dates?
  end
end
