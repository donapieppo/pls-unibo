# frozen_string_literal: true
include LinkHelper

class ResourcesComponent < ViewComponent::Base
  def initialize(what:)
    @what = what
    @resources = @what.resources
  end
end

