class ActivitiesController < ApplicationController
  before_action :set_activity_and_check_permission, only: %i[ edit update destroy choose_contact add_contact ]

  def index
    authorize :activity
    @activities = Activity.includes(:editions, :activity_type).order(:name)
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

  def choose_contact
    authorize @activity
    @url = add_contact_activity_path(@activity)
    render 'contacts/add_contact'
  end

  def add_contact
    authorize @activity
    @contact = Contact.find(params[:contact_id])
    @contact.contact_records.new(record_type: 'Activity', record_id: @activity.id).save
    redirect_to [:edit, @activity]
  end

  private

  def set_activity_and_check_permission
    @activity = Activity.find(params[:id])
    authorize @activity
  end

  def activity_params
    params[:activity].permit(:name, :description, :audience_id, :activity_type_id, :global, area_ids: [])
  end
end
