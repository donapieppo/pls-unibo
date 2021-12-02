class EditionsController < ApplicationController
  include ContactConcern
  include ResourceConcern
  before_action :set_edition_and_check_permission, only: %i[ show edit update destroy add_contact remove_contact add_speaker remove_speaker choose_resource add_resource remove_resource ]

  def index
    authorize :edition
    @editions = Edition.includes(:events).order(:name)
    unless current_user && current_user.staff?
      @editions = @editions.where('activities.hidden != 1')
    end
  end

  def show
    @events = @edition.events.order([:name]).with_rich_text_details.all
  end

  def new
    @project = Project.find(params[:project_id])
    @edition = @project.editions.new(name: @project.name,
                                     audience_id: @project.audience_id)
    authorize @edition
  end

  def create
    @project = Project.find(params[:project_id])
    @edition = @project.editions.new(edition_params)
    authorize @edition
    if @edition.save
      redirect_to [:edit, @edition], notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @edition.update(edition_params)
      redirect_to [:edit, @edition.project], notice: 'OK'
    else
      render action: :edit
    end
  end

  def destroy
    if @edition.destroy
      flash[:notice] = 'OK'
    end
    redirect_to [:edit, @edition.project]
  end

  private

  def set_edition_and_check_permission
    @edition = Edition.find(params[:id])
    authorize @edition
  end

  # Fixme booking_url only if external
  def edition_params
    params[:edition].permit(:hidden, :in_presence, :online, :name, :description, :details, :academic_year, :audience_id, :seats, :sofia, :pcto, :bookable, :booking_url, :booking_start, :booking_end, :atomic)
  end
end
