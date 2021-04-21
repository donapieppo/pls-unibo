module LinkHelper
  def link_to_delete(url, button: false)
    link_to url, method: :delete, title: 'elimina', data: { confirm: 'Siete sicuri di voler cancellare?' } do 
      '<i class="far fa-trash-alt"></i>'.html_safe
    end
  end

  def link_to_remove(item, parent)
    # remove_contact_project_contact_path
    url = [:remove_contact, parent, contact_id: item.id]
    link_to url, method: :delete, title: 'elimina', data: { confirm: 'Siete sicuri di voler cancellare?' } do 
      '<i class="far fa-trash-alt"></i>'.html_safe
    end
  end
end

