class ApplicationController < ActionController::Base
  before_action :set_current_user
  # allow_browser versions: :modern

  helper_method :current_user

  after_action :verify_authorized

  impersonates :user

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_current_user
    user_id = request.session[:user_id]

    # check expired only if session :user_id present
    return unless user_id

    if session_expired?
      request.session.delete(:user_id)
      request.session.delete(:authenticated_at)
      return
    end

    @_current_user = ::User.find_by(id: user_id)
  end

  def current_user
    @_current_user
  end

  private

  def user_not_authorized
    flash[:alert] = "Operazione non permessa."
    # redirect_back(fallback_location: root_path)
    redirect_to root_path
  end

  def session_expired?
    authenticated_at = request.session[:authenticated_at].to_i
    return true if authenticated_at.zero?
    # 2.weeks.to_i
    Time.current.to_i - authenticated_at >= 1_209_600
  end
end
