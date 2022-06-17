# frozen_string_literal: true

class Menu::MenuComponent < ViewComponent::Base
  def initialize(current_user)
    @current_user = current_user
  end
end


