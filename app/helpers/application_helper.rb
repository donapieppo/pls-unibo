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

  def possible_label(_label, _txt)
    return "" if _txt.blank?
    "#{_label}: #{_txt}"
  end

  def possible_label_from_array(_label, _arr)
    res = ""
    _arr.each do |item|
      res += ', ' unless res.blank?
      if item.respond_to?(:email)
        res += mail_to item.email, item
      else
        res += link_to item, item
      end
    end
    unless res.blank?
      res= _label +  ": " + res
    end
    content_tag :div, res.html_safe
  end
end

include IconHelper
include ImageHelper
include LinkHelper
include ResourceHelper
