class EditionsController < ApplicationController
  before_action :set_edition_and_check_permission, only: %i[ edit update destroy ]

  def index
    authorize :edition
    @editions = Edition.includes(:events).order(:name)
  end

  def new
    @activity = Activity.find(params[:activity_id])
    @edition = @activity.editions.new(name: @activity.name,
                                      audience_id: @activity.audience_id)
    authorize @edition
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @edition = @activity.editions.new(edition_params)
    authorize @edition
    if @edition.save
      redirect_to [:edit, @activity], notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @edition.update(edition_params)
      redirect_to [:edit, @edition.activity], notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_edition_and_check_permission
    @edition = Edition.find(params[:id])
    authorize @edition
  end

  def edition_params
    params[:edition].permit(:name, :description, :academic_year, :audience_id)
  end
end
