# frozen_string_literal: true

class Area::InlineOrganizationsComponent < ViewComponent::Base
  def initialize(areas)
    @areas = areas
  end

  def render?
    @areas.any?
  end
end

