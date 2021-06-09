# frozen_string_literal: true

class BookingAndActionsComponent < ViewComponent::Base
  def initialize(what:)
    @what = what
  end
end

