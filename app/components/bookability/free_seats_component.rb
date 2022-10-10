# frozen_string_literal: true

class Bookability::FreeSeatsComponent < ViewComponent::Base
  def initialize(what)
    @what = what
    @free_seats = @what.free_seats.to_i
  end
end
