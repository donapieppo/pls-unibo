# frozen_string_literal: true

class EditionComponent < ViewComponent::Base
  def initialize(edition:, short: false, title_if_different_from: false)
    @edition = edition
    @short = short
    @title_if_different_from = title_if_different_from

    @events = @edition.events.order(:start_date).all  
    @resources = @edition.resources
  end
end
