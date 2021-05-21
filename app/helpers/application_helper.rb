module ApplicationHelper
  def current_user_booked?(id)
    @booked_activity_ids ||= @current_user ? @current_user.bookings.map(&:activity_id) : []
    @booked_activity_ids.include?(id)
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def academic_year(y)
    "a.a. #{y}/#{y.to_i + 1}"
  end
end

include IconHelper
include ImageHelper
include LinkHelper
include ResourceHelper
