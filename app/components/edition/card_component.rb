# frozen_string_literal: true

class Edition::CardComponent < ViewComponent::Base
  def initialize(edition, with_project: false)
    @edition = edition
    @with_project = with_project
    # @events = @edition.events.future.order(start_date: :asc).all  
    # @past_events = @edition.events.past.order(start_date: :desc).all  
    # @all_events = @events + @past_events
  end
end
