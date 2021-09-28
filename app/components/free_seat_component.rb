# frozen_string_literal: true

class FreeSeatComponent < ViewComponent::Base
  def initialize(activity:)
    @activity = activity
    if @activity.seats.to_i > 0
      @free_seats = @activity.seats - @activity.bookings.sum(:seats)
    end
  end
end


