class ResourcesController < ApplicationController
  before_action :set_resource_and_check_permission, only: %i[ show edit update destroy ]

  def index
    authorize :resource
    @resources = Resource.includes(:resource_items).all
  end

  def show
  end

  def new
    @resource = Resource.new
    authorize :resource
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)
    authorize @resource
    if @resource.save
      redirect_to [:edit, @resource], notice: "Resource was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
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
    respond_to do |format|
      format.html { redirect_to resources_url, notice: "Resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_resource_and_check_permission
    @resource = Resource.find(params[:id])
    authorize @resource
  end

  def resource_params
    params[:resource].permit(:name, :description, area_ids: [])
  end
end
