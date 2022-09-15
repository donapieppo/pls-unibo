# frozen_string_literal: true

class Booking::ActivityCardComponent < ViewComponent::Base
  def initialize(activity, details: false)
    @activity = activity
    @details = details
  end

  def render?
    @activity.booking_start && @activity.booking_end
  end
end
