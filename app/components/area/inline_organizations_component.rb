# frozen_string_literal: true

class Area::InlineOrganizationsComponent < ViewComponent::Base
  def initialize(areas, title: 'Organizzato da')
    @areas = areas
    @title = title
  end

  def render?
    @areas.any?
  end
end
