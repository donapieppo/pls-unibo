# frozen_string_literal: true

class Booking::ActivityLineComponent < ViewComponent::Base
  def initialize(activity, details: false)
    @activity = activity
  end

  def render?
    @activity.booking_start && @activity.booking_end
  end
end
