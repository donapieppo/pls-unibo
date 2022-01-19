# frozen_string_literal: true

class Activity::DateAndPlaceComponent < ViewComponent::Base
  def initialize(activity)
    @activity = activity
  end
end
