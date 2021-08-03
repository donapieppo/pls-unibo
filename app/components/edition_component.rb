# frozen_string_literal: true

class EditionComponent < ViewComponent::Base
  def initialize(edition:, short: false, title_if_different_from: false, skip_title: false)
    @edition = edition
    @short = short
    @skip_title = skip_title || (title_if_different_from && @edition.name == @title_if_different_from)

    @events = @edition.events.order(:start_date).all  
    @resources = @edition.resources
  end
end
