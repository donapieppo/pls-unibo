# frozen_string_literal: true
include LinkHelper

class Resourceable::TabComponent < ViewComponent::Base
  def initialize(t, what: nil)
    @t = t
    @what = what
  end
end
