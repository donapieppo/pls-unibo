# frozen_string_literal: true

class Event::ListComponent < ViewComponent::Base
  def initialize(events:, short: false, with_image: true, title: nil)
    @events = events
    @short = short
    @with_image = with_image
    @title = title ? title : 'prossimi eventi'
  end

  def render?
    @events.any?
  end
end


