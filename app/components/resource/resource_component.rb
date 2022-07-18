# frozen_string_literal: true

class Resource::ResourceComponent < ViewComponent::Base
  def initialize(resource, small: false)
    @resource = resource
    @small = small
    @limit = @small ? 250 : 400
  end
end

