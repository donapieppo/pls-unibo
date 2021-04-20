class EventsController < ApplicationController
  include ContactConcern
  before_action :set_event_and_check_permission, only: %i[ edit update destroy choose_contact add_contact add_speaker ]

  def index
    authorize :event
    @events = Event.order(:name)
  end

  def new
    if params[:from]
      orig = Event.find(params[:from])
      @edition = Edition.find(orig.parent_id)
      @event = @edition.events.new(orig.attributes)
    else
      @edition = Edition.find(params[:edition_id])
      @event = @edition.events.new
    end
    authorize @event
  end

  def create
    @edition = Edition.find(params[:edition_id])
    @event = @edition.events.new(event_params)
    authorize @event
    if @event.save
      redirect_to [:edit, @event], notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
    @edition = @event.edition
  end

  def update
    if @event.update(event_params)
      redirect_to [:edit, @event], notice: 'OK'
    else
      render action: :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'OK'
    end
    redirect_to [:edit, @event.edition]
  end

  private

  def set_event_and_check_permission
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params[:event].permit(:name, :description, :academic_year, :where, :start_date, :duration, :seats)
  end
end
