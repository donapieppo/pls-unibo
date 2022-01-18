# frozen_string_literal: true

class Booking::ActivityListComponent < ViewComponent::Base
  def initialize(current_user)
    @activities = Activity.order('start_date desc').with_bookings
    @current_user = current_user
  end
end

