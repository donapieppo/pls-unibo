# frozen_string_literal: true

class FreeSeatComponent < ViewComponent::Base
  def initialize(activity:)
    @activity = activity
    @free_seats = @activity.free_seats
  end
end


