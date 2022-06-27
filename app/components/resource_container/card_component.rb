class ResourceContainer::CardComponent < ViewComponent::Base
  def initialize(resource_container, current_user)
    @resource_container = resource_container
    @current_user = current_user
  end
end


