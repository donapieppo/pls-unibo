# frozen_string_literal: true

class Bookability::InfoComponent < ViewComponent::Base
  def initialize(what)
    @what = what
    if @what.bookable?
      @free_seats = @what.free_seats
    end
  end

  private 

  def render?
    @what.external_booking? || @what.bookable?
  end
end

