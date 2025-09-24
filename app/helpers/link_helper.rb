module LinkHelper
  def link_to_delete_if_deletable(name, what)
    if policy(what).destroy?
      link_to_delete(name, what)
    end
  end

  def link_to_edit_if_editable(what, msg: "", add_class: "pl-2 inline-block text-base")
    if policy(what).edit?
      content_tag(:div, class: add_class) do
        link_to(edit_icon + content_tag(:span, msg, class: "pl-1"), [:edit, what])
      end
    end
  end

  def link_to_delete(name, url, button: false, add_class: "", size: nil, confirm_message: "Siete sicuri di voler cancellare?")
    add_class += if button
      " button-danger"
    else
      " inline-block px-0 mx-0 cursor-pointer"
    end
    button_to url,
      method: :delete,
      title: "elimina",
      class: "cursor-pointer",
      form_class: add_class,
      form: {data: {"turbo-confirm": confirm_message}} do
      dm_icon("trash-alt", text: name, size: size)
    end
  end

  def dm_icon(name, prefix = "solid", text: nil, size: nil, fw: true)
    text = text.blank? ? "" : " #{text}"
    c = "fa-#{prefix} fa-#{name} "
    c += " fa-#{size}" if size
    c += " fa-fw" if fw
    content_tag(:i, "", class: c) + text
  end

  # def link_to_remove(item, parent)
  #   # remove_contact_project_contact_path
  #   url = [:remove_contact, parent, contact_id: item.id]
  #   link_to url, method: :delete, title: 'elimina', data: { confirm: 'Siete sicuri di voler cancellare?' } do
  #     '<i class="far fa-trash-alt"></i>'.html_safe
  #   end
  # end
end
