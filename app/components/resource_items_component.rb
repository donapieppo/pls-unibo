# frozen_string_literal: true
include LinkHelper

class ResourceItemsComponent < ViewComponent::Base
  def initialize(resource_item)
    @resource_item = resource_item
  end
end

