# frozen_string_literal: true

class Resource::ResourceComponent < ViewComponent::Base
  def initialize(resource, current_user = nil, size: :base, with_download: false)
    @resource = resource
    @current_user = current_user
    @with_download = with_download

    if @with_download
      @link_url = if !@resource.url.blank?
        @resource.url
      elsif @resource.image? || @resource.document_type == "document"
        @resource.document
      end
    end

    @policy = ResourcePolicy.new(@current_user, @resource)
    @small = (size == :small)
    @limit = case size
    when :small
      250
    when :base
      350
    when :big
      800
    end
  end
end
