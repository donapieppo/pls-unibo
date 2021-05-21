module ImageHelper
  def area_image(area)
    "media/images/#{area.name.downcase.gsub(' ', '')}.jpg"
  end

  def area_icon(area, size: 40)
    image_pack_tag "media/images/#{area.name.downcase.gsub(' ', '')}.png", size: size
  end
end
