# frozen_string_literal: true
include LinkHelper

class Event::EditComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    @events = @what.events.order("start_date desc")
  end
end
