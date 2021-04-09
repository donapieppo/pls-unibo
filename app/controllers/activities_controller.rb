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
    @activity = Activity.new(activity_params)
    authorize @activity
    if @activity.save
      redirect_to activities_path, notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to activities_path, notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_activity_and_check_permission
    @activity = Activity.find(params[:id])
    authorize @activity
  end

  def activity_params
    params[:activity].permit(:name, :description)
  end
end
