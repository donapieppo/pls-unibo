# frozen_string_literal: true

class Activity::DateAndPlaceComponent < ViewComponent::Base
  def initialize(activity, no_link: false)
    @activity = activity
    @no_link = no_link
  end
end
