# frozen_string_literal: true

class Booking::ListComponent < ViewComponent::Base
  def initialize(bookings, current_user)
    @bookings = bookings
    @current_user = current_user
  end
end


