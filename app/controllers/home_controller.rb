class HomeController < ApplicationController
  before_action :skip_authorization

  def index
    @areas = Area.includes(:contact).order(:name).all
    authorize :home
  end

  def contacts
  end

  def presentazione
  end
end
