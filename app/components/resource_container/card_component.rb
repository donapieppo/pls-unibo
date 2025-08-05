class ResourceContainer::CardComponent < ViewComponent::Base
  def initialize(resource_container, current_user, compressed: false)
    @resource_container = resource_container
    @current_user = current_user
    @resource_container_policy = ResourceContainerPolicy.new(@current_user, @resource_container)
    @compressed = compressed
  end
end
