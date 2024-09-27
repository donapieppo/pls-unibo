# frozen_string_literal: true

class Resource::ResourceComponent < ViewComponent::Base
  def initialize(resource, size: :base, with_download: false, name: false)
    @resource = resource
    @with_download = with_download
    @resource_name = (name == :complete) ? resource.name : resource.to_s
    @link_url = nil

    if @with_download
      @link_url = if !@resource.url.blank?
        @external_link = true
        @resource.url
      elsif @resource.image? || @resource.document_type == "document"
        # FIXME
        @resource.document
      end
    end

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
