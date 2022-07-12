# frozen_string_literal: true

class Contact::InlineSpeakersComponent < ViewComponent::Base
  def initialize(contacts)
    @contacts = contacts
  end

  def render?
    @contacts.any?
  end
end

