module ResourceHelper
  def resource_item_icon(resource)
    if resource.video?
      '<i class="fas fa-video"></i>'.html_safe
    elsif resource.image?
      '<i class="far fa-images"></i>'.html_safe
    else
      ''
    end
  end
end
