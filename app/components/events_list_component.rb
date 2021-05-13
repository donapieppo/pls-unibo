# frozen_string_literal: true

class EventsListComponent < ViewComponent::Base
  def initialize(events:, short: false)
    @events = events
    @short = short
  end
end


