# frozen_string_literal: true

class Booking::ActivityCardComponent < ViewComponent::Base
  def initialize(activity, current_user, details: false)
    @activity = activity
    @current_user = current_user
    @bookings = @activity.bookings.includes(:user, :school).order(:created_at)
    @details = details
  end

  def render?
    @activity.booking_start && @activity.booking_end
  end
end
