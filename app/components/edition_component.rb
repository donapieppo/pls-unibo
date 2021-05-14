# frozen_string_literal: true

class EditionComponent < ViewComponent::Base
  def initialize(edition:)
    @edition = edition
    @events = @edition.events.order(:start_date).all  
    @resources = @edition.resources
  end
end
