# frozen_string_literal: true

class FlashMessagesComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
  end
end

