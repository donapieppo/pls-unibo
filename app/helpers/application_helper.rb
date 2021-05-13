module ApplicationHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
end

include IconHelper
include ImageHelper
include LinkHelper
include ResourceHelper
