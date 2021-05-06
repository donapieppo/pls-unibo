# frozen_string_literal: true

class EditionComponent < ViewComponent::Base
  def initialize(edition:, can_edit: false)
    @edition = edition
    @events = @edition.events.order(:start_date).all  
    @can_edit = can_edit
  end
end
