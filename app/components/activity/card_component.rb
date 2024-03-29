class Activity::CardComponent < ViewComponent::Base
  def initialize(activity, no_filter: false, in_evidence: false)
    @activity = activity
    @current_year = @activity.current_year?
    @hidden = @activity.hidden?
    @in_evidence = in_evidence && !@hidden

    @card_style = @current_year ? "border-pls-strong bg-gray-50" : "bg-gray-200 opacity-60"

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
