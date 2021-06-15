# frozen_string_literal: true
include LinkHelper

class ResourceContainersComponent < ViewComponent::Base
  def initialize(what:)
    @what = what
    @resource_containers = @what.resource_containers
  end
end

