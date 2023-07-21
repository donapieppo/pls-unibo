class PagesController < ApplicationController
  before_action :skip_authorization

  def scienza_al_cinema
    @edition = Edition.find(392)
    @dates = "dal 17 ott 2022"
    set_events
  end

  def scienza_al_cinema_2023
    @edition = Edition.find(527)
    set_events
    @dates = "dal 21 ott 2023"
    render action: :scienza_al_cinema
  end

  def workshop21
    @edition = Edition.find(121)
    set_events
  end

  def workshop22
    @edition = Edition.find(384)
    set_events
  end

  def metodi_matematici_animazione
    @edition = Edition.find(282)
    set_events
  end

  private

  def set_events
    @events = @edition.events.future.order(start_date: :asc).all
    @past_events = @edition.events.past.order(start_date: :desc).all
    @all_events = @events + @past_events
  end
end
