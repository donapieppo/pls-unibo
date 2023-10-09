# frozen_string_literal: true

class Booking::UserListComponent < ViewComponent::Base
  def initialize(bookings, current_user)
    @bookings = bookings
    @current_user = current_user
    @online_mails = []
    @in_presence_mails = []
    @teacher_mails = []
  end
end
