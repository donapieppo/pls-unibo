module AreaHelper
  def areas_to_s(areas)
    areas.each do |area|
      concat(link_to area.name, area_root(area))
    end
  end
end
