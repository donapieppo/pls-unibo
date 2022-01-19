# frozen_string_literal: true

class Event::EventComponent < ViewComponent::Base
  def initialize(event, current_user, no_edition: false, heading: :h1)
    @event = event
    @current_user = current_user
    @editable = EventPolicy.new(@current_user, @event).edit?
    @no_edition = no_edition
    @heading = heading
  end
end
