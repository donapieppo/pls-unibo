module IconHelper
  def logout_icon
    '<i class="fas fa-sign-out-alt"></i>'.html_safe
  end

  def add_icon
    '<i class="fas fa-plus-circle"></i>'.html_safe
  end

  def trash_icon(size: 24)
    '<i class="far fa-trash-alt"></i>'.html_safe
  end

  def edit_icon
    '<i class="fas fa-edit ml-2"></i>'.html_safe
  end

  def document_icon
    '<i class="far fa-file-alt"></i>'.html_safe
  end

  def clone_icon
    '<i class="far fa-clone"></i>'.html_safe
  end

  def link_icon
    '<i class="fas fa-external-link-alt"></i>'.html_safe
  end

  def mail_icon
    '<i class="far fa-envelope"></i>'.html_safe
  end
end
