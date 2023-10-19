# frozen_string_literal: true

class Resource::DetailsComponent < ViewComponent::Base
  def initialize(resource, current_user = nil, with_actions: false)
    @resource = resource
    @current_user = current_user
    @with_actions = with_actions
    @policy = ResourcePolicy.new(@current_user, @resource)
  end
end
