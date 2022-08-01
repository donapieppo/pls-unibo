# frozen_string_literal: true

class Booking::UserListComponent < ViewComponent::Base
  def initialize(activity:, current_user: nil)
    @activity = activity
    @current_user = current_user

    @bookings = @activity.bookings.includes(:user, :school).order(:created_at)
    @activity_online_mails = []   
    @activity_in_presence_mails = []   
    @teacher_mails = []

    @editable = @current_user && @current_user.staff?
  end
end

