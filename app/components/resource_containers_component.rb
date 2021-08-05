# frozen_string_literal: true
include LinkHelper

class ResourceContainersComponent < ViewComponent::Base
  def initialize(what:, short: false)
    @what = what
    @short = short
    @resource_containers = @what.resource_containers
  end
end

