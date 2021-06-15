# frozen_string_literal: true

class EditionComponent < ViewComponent::Base
  def initialize(edition:, title_if_different_from:)
    @edition = edition
    @events = @edition.events.order(:start_date).all  
    @resources = @edition.resources
    @title_if_different_from = title_if_different_from
  end
end
