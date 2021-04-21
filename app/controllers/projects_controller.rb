class ProjectsController < ApplicationController
  include ContactConcern
  before_action :set_project_and_check_permission, only: %i[ edit update destroy choose_contact add_contact remove_contact ]

  def index
    authorize :project
    @projects = Project.includes(:editions, :activity_type).order(:name)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      redirect_to [:edit, @project], notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to [:edit, @project], notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_project_and_check_permission
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params[:project].permit(:name, :description, :audience_id, :parent_id, :global, interested_area_ids: [], area_ids: [])
  end
end
