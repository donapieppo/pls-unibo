# frozen_string_literal: true
include LinkHelper

class Edition::EditComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    @editions = @what.editions.order("start_date desc")
  end
end
