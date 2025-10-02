module IconHelper
  def icon(what, size = "")
    "<i class=\"#{what} #{size}\"></i>".html_safe
  end

  def logout_icon(size: "")
    icon "fas fa-sign-out-alt", size
  end

  def add_icon(size: "")
    icon "fas fa-plus-circle", size
  end

  def trash_icon(size: "")
    icon "far fa-trash-alt", size
  end

  def edit_icon
    icon "fas fa-edit"
  end

  def download_icon
    icon "fas fa-download"
  end

  def document_icon(size: "")
    icon "far fa-file-alt", size
  end

  def clone_icon
    icon "far fa-clone"
  end

  def plus_icon(size: "")
    icon "far fa-plus-square", size
  end

  def link_icon(size: "")
    icon "fas fa-external-link-alt", size
  end

  def mail_icon
    icon "far fa-envelope"
  end

  def booking_icon
    icon "fas fa-user-clock"
  end

  def eye_icon
    icon "fas fa-eye"
  end

  def exclamation_icon
    icon "fas fa-exclamation-circle"
  end

  def facebook_icon
    icon "fab fa-facebook-square"
  end

  def youtube_icon
    icon "fab fa-youtube"
  end

  def calendar_icon
    icon "far fa-calendar"
  end

  def clock_icon
    icon "far fa-clock"
  end

  def attach_type_icon(content_type)
    case content_type
    when "application/pdf"
      '<i class="fa-solid fa-file-pdf fa-xl fa-fw"></i>'.html_safe
    when "application/msword"
      '<i class="fa-regular fa-file-word fa-xl fa-fw"></i>'.html_safe
    when "application/zip"
      '<i class="fa-solid fa-file-zipper fa-xl fa-fw"></i>'.html_safe
    else
      '<i class="fa-solid fa-file fa-xl fa-fw"></i>'.html_safe
    end
  end
end
