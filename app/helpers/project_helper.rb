module ProjectHelper
  def project_academic_years_to_s(project)
    if project.cache_years.size > 1
      "dall'" + academic_year(project.cache_years.first) + " all'" + academic_year(project.cache_years.last)
    elsif project.cache_years.size == 1
      academic_year(project.cache_years.first)
    end
  end
end
