class ApplicationController < ActionController::Base
  include ApplicationHelper

  after_action :verify_authorized

  include Pundit
end
