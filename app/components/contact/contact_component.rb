# frozen_string_literal: true

class Contact::ContactComponent < ViewComponent::Base
  def initialize(contact, current_user)
    @contact = contact
    @current_user = current_user
    @contactPolicy = ContactPolicy.new(@current_user, @contact)
  end
end

