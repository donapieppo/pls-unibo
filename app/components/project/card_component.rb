class Project::CardComponent < ViewComponent::Base
  def initialize(project, no_filter: false)
    @project = project
    current_year = @project.current_year?
    @border_color = current_year ? 'border-pls-light' : 'border-gray-200'
    @opacity = current_year ? '' : 'opacity-60'
    @other_areas = @project.interested_areas - @project.areas

    @filter_data = no_filter ? {} : { 
      years: @project.cache_years,
      audiences: @project.editions_audience_ids.uniq,
      areas: (@project.area_ids + @project.interested_area_ids).uniq, 
      activityTypes: (@project.parent_id ? [@project.parent_id] : []) 
    } 
  end
end

