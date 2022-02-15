# frozen_string_literal: true

class Booking::ActivityListComponent < ViewComponent::Base
  def initialize(current_user)
    @activities = Activity.order('start_date desc').with_bookings.bookable_undone
    @current_user = current_user
  end
end

