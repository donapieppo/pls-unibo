# frozen_string_literal: true

class Booking::UserListComponent < ViewComponent::Base
  def initialize(activity:, current_user: nil)
    @activity = activity
    @current_user = current_user
    @activity_online_mails = []   
    @activity_in_presence_mails = []   
  end
end

