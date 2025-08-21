module AreaHelper
  def areas_to_s(areas)
    areas.map(&:name).join(", ")
  end
end
