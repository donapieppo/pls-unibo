# frozen_string_literal: true

class Bookability::InfoComponent < ViewComponent::Base
  def initialize(what)
    @what = what
    if @what.bookable?
      @free_seats = @what.free_seats
    end
  end

  def render?
    @what.bookable?
  end
end

