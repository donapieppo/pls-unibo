# frozen_string_literal: true
include LinkHelper

class EditResourcesComponent < ViewComponent::Base
  def initialize(what:)
    @what = what
    @resources = @what.resources
  end
end

