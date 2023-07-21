class Activity::CardComponent < ViewComponent::Base
  def initialize(activity, no_filter: false, in_evidence: false)
    @activity = activity
    current_year = @activity.current_year?
    @border_color = current_year ? "border-gray-400" : "border-gray-100"
    @opacity = current_year ? "" : "opacity-60"
    @hidden = @activity.hidden?
    @in_evidence = in_evidence && !@hidden

    @project = @activity.is_a?(Project) ? @activity : @activity.project

    @activity_type = @project.activity_type
    @organization = @project.organization
    @campus = @project.campus
    @other_areas = @project.interested_areas - @project.areas

    # @other_areas = @project.interested_areas - @project.areas

    if @activity.is_a?(Project)
      @filter_data = no_filter ? {} : {
        years: @activity.cache_years,
        audiences: @activity.editions_audience_ids.uniq,
        areas: (@activity.area_ids + @activity.interested_area_ids).uniq,
        activityTypes: (@activity.parent_id ? [@activity.parent_id] : [])
      }
    end
  end
end
