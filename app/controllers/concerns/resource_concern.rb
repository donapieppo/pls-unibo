module ResourceConcern
  extend ActiveSupport::Concern

  def choose_resource
    @what = @project || @edition || @event || @resource_container
    @resources = Hash.new { |hash, key| hash[key] = [] }
    Resource.where.not(id: @what.resource_ids).order(:name).with_attached_document.each do |r|
      @resources[r.document_type] << r
    end
    render "resources/choose_resource"
  end

  def add_resource
    @what = @project || @edition || @event || @resource_container
    @resource = Resource.find(params[:resource_id])
    @what.resources << @resource
    redirect_to [:edit, @what]
  end

  def remove_resource
    @what = @project || @edition || @event || @resource_container
    @resource = Resource.find(params[:resource_id])
    @what.resources.delete(@resource)
    redirect_to [:edit, @what]
  end
end
