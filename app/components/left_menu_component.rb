# frozen_string_literal: true

class LeftMenuComponent < ViewComponent::Base
  def initialize(where:, infos:)
    @infos = infos
  end
end
