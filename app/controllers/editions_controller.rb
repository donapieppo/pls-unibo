class EditionsController < ApplicationController
  include ContactConcern
  before_action :set_edition_and_check_permission, only: %i[ edit update destroy choose_contact add_contact add_speaker ]

  def index
    authorize :edition
    @editions = Edition.includes(:events).order(:name)
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
      redirect_to [:edit, @project], notice: 'OK'
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
  end

  private

  def set_edition_and_check_permission
    @edition = Edition.find(params[:id])
    authorize @edition
  end

  def edition_params
    params[:edition].permit(:name, :description, :academic_year, :audience_id, :seats)
  end
end
