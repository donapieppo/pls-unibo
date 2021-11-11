class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :log_current_user
  after_action :verify_authorized

  include Pundit

  private 

  def log_current_user
    if current_user
      logger.info "Current user: #{current_user.email}" 
    end
  end
end
