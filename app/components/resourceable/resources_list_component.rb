# frozen_string_literal: true
include LinkHelper

class Resourceable::ResourcesListComponent < ViewComponent::Base
  def initialize(resources, current_user)
    @resources = resources
    @current_user = current_user
  end
end
