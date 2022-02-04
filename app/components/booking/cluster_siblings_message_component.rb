# frozen_string_literal: true

class Booking::ClusterSiblingsMessageComponent < ViewComponent::Base
  def initialize(activity)
    @activity = activity
    # FIXME
    @cluster = @activity.clusters.first
    if @cluster
      @siblings = @activity.cluster_siblings 
    end
  end

  def render?
    @cluster && @cluster.max_bookable_activities && @siblings.any? && ( !(@activity.bookable && @activity.external_booking?))
  end
end

