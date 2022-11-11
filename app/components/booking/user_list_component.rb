# frozen_string_literal: true

class Booking::UserListComponent < ViewComponent::Base
  def initialize(bookings)
    @bookings = bookings
    @online_mails = []   
    @in_presence_mails = []   
    @teacher_mails = []
  end
end
