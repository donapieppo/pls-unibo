module ProjectHelper
  def project_academic_years_to_s(project)
    # FIXME
    project.cache_years or project.edition_years 
    if project.cache_years.size > 1
      "dall'" + academic_year(project.cache_years.first) + " all'" + academic_year(project.cache_years.last)
    elsif project.cache_years.size == 1
      academic_year(project.cache_years.first)
    end
  end
end
