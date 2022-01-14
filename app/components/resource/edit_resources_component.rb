# frozen_string_literal: true
include LinkHelper

class Resource::EditResourcesComponent < ViewComponent::Base
  def initialize(what:)
    @what = what
    @resources = @what.resources
  end
end

