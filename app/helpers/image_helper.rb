module ImageHelper
  def area_image(area, size: 40)
    image_pack_tag "#{area.name.downcase.gsub(' ', '')}.jpg", size: size
  end

  def area_icon(area, size: 40)
    image_pack_tag "#{area.name.downcase.gsub(' ', '')}.png", size: size
  end
end
