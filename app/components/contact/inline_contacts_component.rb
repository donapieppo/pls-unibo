# frozen_string_literal: true

class Contact::InlineContactsComponent < ViewComponent::Base
  def initialize(contacts, label: "Contatti")
    @contacts = contacts
    @label = label
  end

  def render?
    @contacts.any?
  end
end
