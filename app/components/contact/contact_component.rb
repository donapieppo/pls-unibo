# frozen_string_literal: true

class Contact::ContactComponent < ViewComponent::Base
  def initialize(contact)
    @contact = contact
  end
end

