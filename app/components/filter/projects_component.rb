# frozen_string_literal: true

class Filter::ProjectsComponent < ViewComponent::Base
  def initialize(no_year_filter: false, no_area_filter: false)
    @no_year_filter = no_year_filter
    @no_area_filter = no_area_filter
  end
end

