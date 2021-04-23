class ResourceItemsController < ApplicationController
  before_action :set_resource_item_and_check_permission, only: %i[ show edit update destroy ]

  def index
    authorize :resource_item
    @resource = Resource.find(params[:resource_id])
    @resource_items = @resource.resource_items.all
  end

  def show
  end

  def new
    authorize :resource_item
    @resource = Resource.find(params[:resource_id])
    @resource_item = @resource.resource_items.new
  end

  def create
    @resource = Resource.find(params[:resource_id])
    @resource_item = @resource.resource_items.new(resource_item_params)
    authorize @resource_item
    if @resource_item.save
      redirect_to [:edit, @resource], notice: "Resource was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
    @resource = @resource_item.resource
  end

  def update
    @resource = @resource_item.resource
    if @resource_item.update(resource_item_params)
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
  def set_resource_item_and_check_permission
    @resource_item = ResourceItem.find(params[:id])
    authorize @resource_item
  end

  def resource_item_params
    params[:resource_item].permit(:name, :url, :document)
  end
end
