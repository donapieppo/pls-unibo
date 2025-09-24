# frozen_string_literal: true

class TitleComponent < ViewComponent::Base
  def initialize(what, editable: false)
    @what = what
    @editable = editable
  end
end

