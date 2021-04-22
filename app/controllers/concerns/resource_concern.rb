module ResourceConcern
  extend ActiveSupport::Concern

  def choose_resource
    @what = @project || @edition || @event
    @url = [:add_resource, @what]
    @resources = Resource.where.not(id: @what.resource_ids).order(:name)
    render 'resources/choose_resource'
  end

  def add_resource
    @what = @project || @edition || @event
    @resource = Resource.find(params[:resource_id])
    @what.resources << @resource
    redirect_to [:edit, @what]
  end

  def remove_resource
    @what = @project || @edition || @event
    @resource = Resource.find(params[:resource_id])
    @what.resources.delete(@resource)
    redirect_to [:edit, @what]
  end
end
