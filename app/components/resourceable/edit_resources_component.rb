# frozen_string_literal: true
include LinkHelper

class Resourceable::EditResourcesComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
  end
end
