class PagesController < ApplicationController
  before_action :skip_authorization

  def scienza_al_cinema
    @edition = Edition.find(110)
    render layout: 'pages'
  end

  def workshop21
    @edition = Edition.find(121)
    render layout: 'pages'
  end

  def metodi_matematici_animazione
    @edition = Edition.find(282)
    render layout: 'application'
  end
end
