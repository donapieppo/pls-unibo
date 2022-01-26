# frozen_string_literal: true

class Edition::EditionComponent < ViewComponent::Base
  def initialize(edition, current_user, short: false, title_if_different_from: false, skip_title: false, with_image: false)
    @edition = edition
    @current_user = current_user
    @short = short
    @skip_title = skip_title || (title_if_different_from && @edition.name == @title_if_different_from)
    @with_image = with_image

    @events = @edition.events.order(:start_date).all  
    @resources = @edition.resources
  end
end
