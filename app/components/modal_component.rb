# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(title: "", hidden: false, noactions: false, small: false)
    @title = title
    @hidden = hidden
    @small = small
    @actions = noactions ? "" : "turbo:click->turbo-modal#followLink 
                                 keyup@window->turbo-modal#closeWithKeyboard
                                 click@window->turbo-modal#closeBackground
                                 turbo:submit-end->turbo-modal#submitEnd" 
  end
end

