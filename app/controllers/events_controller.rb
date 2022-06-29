class EventsController < ApplicationController
  include ContactConcern
  include ResourceConcern
  before_action :set_event_and_check_permission, only: %i[ show edit update destroy add_contact remove_contact add_speaker remove_speaker choose_resource add_resource remove_resource ]

  def index
    authorize :event
    @events = Event.order(:name)
    @events = @events.visible(current_user && current_user.staff?)
  end

  def show
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
      render action: :new, status: :unprocessable_entity
    end
  end

  def edit
    @edition = @event.edition
  end

  def update
    @edition = @event.edition
    if @event.update(event_params)
      redirect_to [:edit, @event], notice: 'OK'
    else
      render action: :edit, status: :unprocessable_entity
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

  # Fixme booking_url only if external
  def event_params
    h = [:hidden, :name, :description, :in_presence, :online, :academic_year, :place, :google_map, :access_url, :start_date, :duration]
    unless @editon && @edition.atomic
      h += [:seats, :sofia, :pcto, :bookable, :bookable_by, :bookable_for, :booking_url, :booking_start, :booking_end]
    end
    params[:event].permit(h)
  end
end
