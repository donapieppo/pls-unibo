class AreasController < ApplicationController
  include ContactConcern

  before_action :set_area_and_check_permission, only: %i[ show edit update destroy add_contact remove_contact ]

  def show
    # si vedono le edizioni di quest'anno
    @edition_evidences = Edition.visible(current_user && current_user.staff?).in_evidence.in_area(@area)
    @editions = Edition.visible(current_user && current_user.staff?).this_academic_year.in_area(@area)
    @common_projects = Project.where(global: true).include_all.visible(current_user && current_user.staff?).order(:name).all
    #@this_area_projects = @area.projects.this_academic_year.include_all.order(:name).visible(current_user && current_user.staff?)
    #@this_area_projects = @this_area_projects.uniq
    @resource_containers = @area.resource_containers.includes(:resources).order(:name).all
  end

  def edit
  end

  def update
    if @area.update(area_params)
      redirect_to root_path, notice: 'OK'
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  private

  def set_area_and_check_permission
    # @area = Area.find_by_slug!(params[:slug])
    @area = Area.find(params[:id])
    authorize @area
  end

  def area_params
    params[:area].permit(:description, :head_id, :notice)
  end
end
