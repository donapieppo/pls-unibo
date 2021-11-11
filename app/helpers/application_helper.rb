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

  def possible_label_from_array(_label, _arr, with_link: true, add_class: '', separator: ' ')
    res = ""
    _arr.each do |item|
      res += separator unless res.blank?
      if item.is_a?(Area)
        res += link_to item, "/#{item.slug}", class: add_class
      elsif item.is_a?(Contact)
        res += render(item)
      elsif with_link && item.respond_to?(:email) 
        res += item.email.blank? ? item.cn : mail_to(item.email, item)
      elsif with_link
        res += link_to item, item, class: add_class
      end
    end
    unless res.blank?
      res = "<strong>" + _label +  "</strong>: " + res
    end
    content_tag :div, res.html_safe, class: 'my-4' unless res.blank?
  end

  def area_root(area)
    "/#{area.slug}"
  end
end

include IconHelper
include ImageHelper
include LinkHelper
include ResourceHelper
include AreaHelper
include ContactHelper
