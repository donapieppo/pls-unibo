class AreasController < ApplicationController
  include ContactConcern

  before_action :set_area_and_check_permission, only: %i[ show edit update destroy add_contact remove_contact ]

  def show
    @this_area_evidence = Edition.in_evidence.in_area(@area)
    @this_area_projects = @area.projects.this_academic_year.includes(:editions, :activity_type).order(:name)
    @common_projects = Project.where(global: true).includes(:editions, :activity_type).order(:name).all
    @resource_containers = @area.resource_containers.includes(:resources).all
    unless current_user && current_user.staff?
      @this_area_projects = @this_area_projects.visible
    end
    @this_area_projects = @this_area_projects.uniq
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

  def set_area_and_check_permission
    # @area = Area.find_by_slug!(params[:slug])
    @area = Area.find(params[:id])
    authorize @area
  end

  def area_params
    params[:area].permit(:description, :head_id)
  end
end
