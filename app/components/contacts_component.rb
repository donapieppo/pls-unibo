# frozen_string_literal: true

class ContactsComponent < ViewComponent::Base
  def initialize(what:, as: nil, can_add: false)
    @what = what

    @as = as
    if @as == :speakers
      @label = 'RELATORI'
      @contacts = @what.speakers
      @url = [:choose_contact, @what, as_speaker: 1]
    else
      @label = 'CONTATTI'
      @contacts = @what.contacts
      @url = [:choose_contact, @what]
    end
  end
end

