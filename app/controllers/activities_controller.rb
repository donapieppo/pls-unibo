class ActivitiesController < ApplicationController
  before_action :set_activity_and_check_permission, only: %i[ edit update destroy ]

  def index
    authorize :activity
    @activities = Activity.order(:name)
  end

  def new
    @activity = Activity.new
    authorize @activity
  end

  def create
  end

  def edit
  end

  def update
    if @area.update(area_params)
      redirect_to root_path, notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_activity_and_check_permission
    @area = Area.find(params[:id])
    authorize @area
  end

  def area_params
    params[:area].permit(:description)
  end
end
