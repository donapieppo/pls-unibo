class ResourcesController < ApplicationController
  before_action :set_resource_and_check_permission, only: %i[ show edit update destroy ]

  def index
    authorize :resource
    @resources = Resource.all
  end

  def show
  end

  def new
    authorize :resource
    @resource = Resource.find(params[:resource_id])
    @resource = @resource.resource.new
  end

  def create
    @resource = Resource.find(params[:resource_id])
    @resource = @resource.resource_items.new(resource_params)
    authorize @resource
    if @resource.save
      redirect_to [:edit, @resource], notice: "Resource was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
    @resource = @resource.resource
  end

  def update
    @resource = @resource.resource
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
    @resource= Resource.find(params[:id])
    authorize @resource
  end

  def resource_params
    params[:resource].permit(:name, :url, :document)
  end
end
