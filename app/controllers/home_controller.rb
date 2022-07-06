class HomeController < ApplicationController
  before_action :skip_authorization

  def index
    @areas = Area.includes(:head).order(:name).all
    @next_editions = Edition.visible(current_user && current_user.staff?).with_next_events(5)
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

  def archive
    @area = Area.find(params[:id])
    @slug = @area.slug
    @slug = 'scienze-naturali-ambientali' if @slug == 'scienze-naturali-e-ambientali'
    @archive_page = "#{config.relative_url_root}/archivio/it/#{@slug}.html"

    render layout: 'archive'
  end
end
