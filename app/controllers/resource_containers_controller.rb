class ResourceContainersController < ApplicationController
  include ResourceableConcern
  before_action :set_resource_container_and_check_permission, only: %i[show edit update destroy choose_resource add_resource remove_resource]

  def index
    authorize :resource_container
    @resource_containers = ResourceContainer.includes(:resources).all
  end

  def show
    @modal = params[:modal]
  end

  def new
    @resource_container = ResourceContainer.new
    authorize :resource_container
  end

  def edit
  end

  def create
    @resource_container = ResourceContainer.new(resource_container_params)
    authorize @resource_container
    if @resource_container.save
      redirect_to [:edit, @resource_container], notice: "Resource was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @resource_container.update(resource_container_params)
      redirect_to [:edit, @resource_container], notice: "Resource was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource_container.destroy
    redirect_to resource_containers_path, notice: "OK."
  end

  private

  def set_resource_container_and_check_permission
    @resource_container = ResourceContainer.find(params[:id])
    authorize @resource_container
  end

  def resource_container_params
    params[:resource_container].permit(:name, :description, area_ids: [])
  end
end
