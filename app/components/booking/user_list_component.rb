# frozen_string_literal: true

class Booking::UserListComponent < ViewComponent::Base
  def initialize(activity)
    @activity = activity

    @bookings = @activity.bookings.includes(:user, :school).order(:created_at)
    @activity_online_mails = []   
    @activity_in_presence_mails = []   
    @teacher_mails = []

    @editable = false
  end
end
