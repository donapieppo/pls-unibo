# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(title: "", hidden: false, noactions: false)
    @title = title
    @hidden = hidden
    @actions = noactions ? "" : "turbo:click->turbo-modal#followLink 
                                 keyup@window->turbo-modal#closeWithKeyboard
                                 click@window->turbo-modal#closeBackground
                                 turbo:submit-end->turbo-modal#submitEnd" 
  end
end

