# frozen_string_literal: true
include LinkHelper

class ContactsComponent < ViewComponent::Base
  def initialize(what:, as: nil, can_add: false)
    @what = what

    @as = as
    if @as == :speaker
      @label = 'RELATORI'
      @contacts = @what.speakers
    else
      @label = 'CONTATTI'
      @contacts = @what.contacts
    end
  end
end

