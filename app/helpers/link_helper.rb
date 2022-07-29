module LinkHelper
  def link_to_delete_if_deletable(what)
    if policy(what).destroy?
      link_to_delete(what)
    end
  end

  def link_to_edit_if_editable(what, msg: '', add_class: 'pl-2 inline-block text-base')
    if policy(what).edit?
      content_tag(:div, class: add_class) do 
        link_to(edit_icon + content_tag(:span, msg, class: 'pl-1 text-sm'), [:edit, what])
      end
    end
  end

  def link_to_delete(name = "", url, button: false, _class: '')
    button_to url, method: :delete, title: 'elimina', form: { data: { 'turbo-confirm': 'Siete sicuri di voler cancellare?'}, 
                                                              class: "inline-block px-0 mx-0 #{_class}" } do
      '<i class="far fa-trash-alt"></i> '.html_safe + name
    end
  end

  # def link_to_remove(item, parent)
  #   # remove_contact_project_contact_path
  #   url = [:remove_contact, parent, contact_id: item.id]
  #   link_to url, method: :delete, title: 'elimina', data: { confirm: 'Siete sicuri di voler cancellare?' } do 
  #     '<i class="far fa-trash-alt"></i>'.html_safe
  #   end
  # end
end

