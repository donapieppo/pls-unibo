class ProjectsController < ApplicationController
  include ContactConcern
  before_action :set_project_and_check_permission, only: %i[ show edit update destroy add_contact remove_contact ]

  def index
    authorize :project
    @projects = Project.includes(:editions, :activity_type).order(:name)
  end

  def show
    @editions = @project.editions.order('academic_year desc, name').with_rich_text_details.all
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
    @editions = @project.editions.order('academic_year desc')
  end

  def update
    if @project.update(project_params)
      redirect_to [:edit, @project], notice: 'OK'
    else
      render action: :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'OK'
    end
    redirect_to projects_path
  end

  private

  def set_project_and_check_permission
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params[:project].permit(:name, :description, :details, :audience_id, :parent_id, :global, interested_area_ids: [], area_ids: [])
  end
end
