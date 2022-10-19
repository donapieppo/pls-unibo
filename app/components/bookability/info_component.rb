# frozen_string_literal: true

class Bookability::InfoComponent < ViewComponent::Base
  def initialize(what)
    @what = what
    if render?
      @free_seats = @what.free_seats
    end
  end

  def render?
    @what.external_booking? || @what.internally_bookable_with_dates?
  end
end
