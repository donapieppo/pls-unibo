# frozen_string_literal: true
include LinkHelper

class Resource::EditComponent < ViewComponent::Base
  def initialize(what, current_user)
    @what = what
    @current_user = current_user
    @resources = @what.resources
  end
end

