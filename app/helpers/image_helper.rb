module ImageHelper
  def area_image(area)
    # "media/images/#{area.name.downcase.gsub(' ', '')}.jpg"
    "#{area.name.downcase.delete(" ")}.jpg"
  end

  def area_icon(area, size: 40)
    # image_pack_tag "media/images/#{area.name.downcase.gsub(' ', '')}.png", size: size
    image_tag "areas/#{area.name.downcase.delete(" ")}.png", size: size, alt: "Area icon"
  end
end
