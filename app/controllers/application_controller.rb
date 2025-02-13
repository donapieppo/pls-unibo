class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user

  before_action :log_current_user
  after_action :verify_authorized

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    # session[:user_id] = User.where("name > 'm' and id>100").first.id
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  impersonates :user

  private

  def log_current_user
    if current_user
      logger.info "Current user: #{current_user.email}"
    end
  end

  def user_not_authorized
    flash[:alert] = "Operazione non permessa."
    # redirect_back(fallback_location: root_path)
    redirect_to root_path
  end
end
