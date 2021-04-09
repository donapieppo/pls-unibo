class HomeController < ApplicationController
  def index
    @areas = Area.order(:name).all
    authorize :home
  end
end
