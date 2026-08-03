# frozen_string_literal: true

class Area::InlineOrganizationsComponent < ViewComponent::Base
  def initialize(areas, label: "Organizzato da:")
    @areas = areas
    @label = label
  end

  def render?
    @areas.any?
  end
end
