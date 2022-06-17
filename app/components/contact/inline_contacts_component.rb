# frozen_string_literal: true

class Contact::InlineContactsComponent < ViewComponent::Base
  def initialize(contacts)
    @contacts = contacts
  end
end

