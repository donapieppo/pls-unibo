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




  def icon_arrow_right_short(size: 24)
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/> </svg>}.html_safe
  end

  def icon_arrow_right_circle(c: 24)
    %Q{<i class="far fa-arrow-alt-circle-right #{c}"></i>}.html_safe
  end

  def icon_arrow_left_circle(size: 24)
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" fill="currentColor" class="bi bi-arrow-left-circle" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5-.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/> </svg>}.html_safe
  end

  def icon_pencil(size: 24)
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16"> <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/> <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/> </svg>}.html_safe
  end

  def icon_plus_circle(size: 24)
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16"> <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/> <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/> </svg>}.html_safe
  end

  def icon_person_check(size: 24)
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" fill="currentColor" class="bi bi-person-check" viewBox="0 0 16 16"> <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/> <path fill-rule="evenodd" d="M15.854 5.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L12.5 7.793l2.646-2.647a.5.5 0 0 1 .708 0z"/> </svg>}.html_safe
  end
end
