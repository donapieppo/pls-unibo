# frozen_string_literal: true

class FlashMessage::FlashMessagesComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
  end
end

