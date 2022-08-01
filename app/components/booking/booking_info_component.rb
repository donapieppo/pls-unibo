# frozen_string_literal: true

class Booking::BookingInfoComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    if @what.bookable?
      @free_seats = @what.free_seats
    end
  end

  def render?
    @what.bookable?
  end
end

