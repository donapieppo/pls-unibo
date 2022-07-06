class ApplicationController < ActionController::Base
  helper_method :current_user

  before_action :log_current_user
  after_action :verify_authorized

  include Pundit::Authorization

  def current_user
    # session[:user_id] = User.where("name > 'm' and id>100").first.id
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  impersonates :user

  private 

  def log_current_user
    if current_user
      logger.info "Current user: #{current_user.email}" 
    end
  end
end
