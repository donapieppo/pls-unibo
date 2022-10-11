# frozen_string_literal: true

class Bookability::InfoComponent < ViewComponent::Base
  def initialize(what)
    @what = what
    if internal_booking_with_dates?
      @free_seats = @what.free_seats
    end
  end

  private 

  def internal_booking_with_dates?
    @what.bookable && @what.bookable != 'no' && @what.booking_start && @what.booking_end
  end

  def render?
    return true if @what.external_booking?
    internal_booking_with_dates?
  end
end
