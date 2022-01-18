# frozen_string_literal: true

class Booking::ActivityBookingsComponent < ViewComponent::Base
  def initialize(activity, current_user)
    @activity = activity
    @current_user = current_user
  end
end


