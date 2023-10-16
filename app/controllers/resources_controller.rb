class ResourcesController < ApplicationController
  before_action :set_what, only: %i[new create]
  before_action :set_resource_and_check_permission, only: %i[show edit update destroy]

  def index
    authorize :resource
    @resources = Hash.new { |hash, key| hash[key] = [] }
    Resource.order(:name).with_attached_document.each do |r|
      @resources[r.document_type] << r
    end
  end

  def show
  end

  def new
    authorize :resource
    @resource = @what.resources.new
  end

  def create
    @resource = Resource.new(resource_params)
    authorize @resource
    if @resource.save
      @what.resources << @resource
      redirect_to [:edit, @what], notice: "Resource was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to [:edit, @resource], notice: "Resource was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: "Resource was successfully destroyed."
  end

  private

  def set_resource_and_check_permission
    @resource = Resource.find(params[:id])
    authorize @resource
  end

  def set_what
    @what = if params[:resource_container_id]
      ResourceContainer.find(params[:resource_container_id])
    else
      Activity.find(params[:event_id] || params[:edition_id] || params[:project_id])
    end
  end

  def resource_params
    params[:resource].permit(:name, :display_name, :url, :document, :credits)
  end
end
