module ResourceableConcern
  extend ActiveSupport::Concern

  def choose_resource
    set_what
    @t = params[:t] || "document"
    @resources = Resource.where
      .not(id: @what.resource_ids)
      .order(:name)
      .where(typology: @t)
    render "resourceable/choose_resource"
  end

  def add_resource
    set_what
    @resource = Resource.find(params[:resource_id])
    @what.resources << @resource
    redirect_to [:edit, @what]
  end

  def remove_resource
    set_what
    @resource = Resource.find(params[:resource_id])
    @what.resources.delete(@resource)
    redirect_to [:edit, @what]
  end

  private

  def set_what
    @what = @project || @edition || @event || @resource_container
  end
end
