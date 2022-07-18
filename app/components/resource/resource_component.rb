# frozen_string_literal: true

class Resource::ResourceComponent < ViewComponent::Base
  def initialize(resource, small: false)
    @resource = resource
    @small = small
    if @small
      @limit = 250
    else
      @limit = 400
    end
  end
end

