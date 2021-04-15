class HomeController < ApplicationController
  def index
    @areas = Area.includes(:contact).order(:name).all
    authorize :home
  end
end
