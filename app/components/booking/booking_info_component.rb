# frozen_string_literal: true

class Booking::BookingInfoComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    @booking = what.bookings.new

    @general_bookable = @what.bookable? && @what.booking_start && @what.booking_end
    @free_seats = @what.free_seats
  end
end

