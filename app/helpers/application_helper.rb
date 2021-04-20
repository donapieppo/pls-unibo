module ApplicationHelper
  def current_user
    return(@current_user) if @current_user
    if Rails.env.development? 
      # session[:user_id] = User.find_by_email('donapieppo@gmail.com').id
      # session[:user_id] = User.find_by_email('bacci.anastasia@gmail.com').id
      # session[:user_id] = User.find_by_contact_email('rubber97@live.it').id
      session[:user_id] = 1
    end
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def link_to_delete(name = "", url, button: false)
    link_to url, method: :delete, title: 'elimina', data: { confirm: 'Siete sicuri di voler cancellare?' } do 
      '<i class="far fa-trash-alt"></i>'.html_safe
    end
  end
end

include IconHelper
include ImageHelper
