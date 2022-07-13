# frozen_string_literal: true

class Filter::ProjectsComponent < ViewComponent::Base
  def initialize(area_id: nil, no_year_filter: false, no_area_filter: false)
    @area_id = area_id.to_i
    @no_year_filter = no_year_filter
    @no_area_filter = no_area_filter
  end
end

