# frozen_string_literal: true

class Event::ListComponent < ViewComponent::Base
  def initialize(events:, short: false, with_image: false)
    @events = events
    @short = short
    @with_image = with_image
  end
end


