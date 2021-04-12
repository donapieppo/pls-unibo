class EventsController < ApplicationController
  before_action :set_event_and_check_permission, only: %i[ edit update destroy ]

  def index
    authorize :event
    @events = Event.order(:name)
  end

  def new
    if params[:from]
      orig = Event.find(params[:from])
      @edition = Edition.find(orig.edition_id)
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
      redirect_to [:edit, @edition], notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to [:edit, @event.edition], notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_event_and_check_permission
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params[:event].permit(:name, :description, :academic_year, :where, :start_date, :end_date)
  end
end
