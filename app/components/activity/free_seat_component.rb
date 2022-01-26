# frozen_string_literal: true

class Activity::FreeSeatComponent < ViewComponent::Base
  def initialize(activity)
    @activity = activity
    @free_seats = @activity.free_seats
  end
end


