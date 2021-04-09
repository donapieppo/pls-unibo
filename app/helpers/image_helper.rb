module ImageHelper
  def area_icon(area, size: 40)
    image_pack_tag "#{area.name.downcase.gsub(' ', '')}.png", size: size
  end

end
