class Project::ListComponent < ViewComponent::Base
  def initialize(projects, area_id: nil, no_filter: false, no_year_filter: false, no_area_filter: false, in_evidence: false)
    @projects = projects
    @area_id = area_id.to_i
    @no_filter = no_filter || @projects.empty?
    @no_year_filter = no_year_filter
    @no_area_filter = no_area_filter
    @in_evidence = in_evidence
  end
end
