class HomeController < ApplicationController
  before_action :skip_authorization

  def index
    @areas = Area.includes(:head).order(:name).all
    authorize :home
  end

  def contacts
  end

  def presentazione
  end

  def privacy
    # render layout: 'pages'
  end

  def search
    @txt = params[:search]
    @activities = Activity.where('name like ?', "%#{@txt}%")
    @schools = School.where('name like ? or code like ?', "%#{@txt}%", "%#{@txt}%")
  end
end
