# frozen_string_literal: true
include LinkHelper

class Snippet::EditComponent < ViewComponent::Base
  def initialize(what)
    @what = what
  end
end

