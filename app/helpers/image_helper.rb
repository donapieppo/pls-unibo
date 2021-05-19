module ImageHelper
  def area_image(area)
    "static/#{area.name.downcase.gsub(' ', '')}.jpg"
  end

  def area_icon(area, size: 40)
    image_pack_tag "static/#{area.name.downcase.gsub(' ', '')}.png", size: size
  end
end
