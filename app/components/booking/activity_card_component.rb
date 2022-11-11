# frozen_string_literal: true

class Booking::ActivityCardComponent < ViewComponent::Base
  def initialize(activity, details: false)
    @activity = activity
    @bookings = @activity.bookings.includes(:user, :school).order(:created_at)
    @details = details
  end

  def render?
    @activity.booking_start && @activity.booking_end
  end
end
