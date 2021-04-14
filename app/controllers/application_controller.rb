class ApplicationController < ActionController::Base
  I18n.locale = :it
  include ApplicationHelper

  after_action :verify_authorized

  include Pundit
end
