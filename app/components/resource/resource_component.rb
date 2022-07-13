# frozen_string_literal: true

class Resource::ResourceComponent < ViewComponent::Base
  def initialize(resource)
    @resource = resource
  end
end

