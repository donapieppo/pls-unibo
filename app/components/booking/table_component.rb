# frozen_string_literal: true

class Booking::TableComponent < ViewComponent::Base
  def initialize(activities)
    @activities = activities
  end
end
