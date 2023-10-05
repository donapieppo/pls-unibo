include IconHelper
include ImageHelper
include LinkHelper
include ResourceHelper
include AreaHelper
include ContactHelper

module ApplicationHelper
  def area_root(area)
    "#{config.relative_url_root}/#{area.slug}"
  end

  def area_archive_root(area)
    "#{area_root(area)}/archive"
  end

  def current_user_booked?(id)
    @booked_activity_ids ||= current_user ? current_user.bookings.map(&:activity_id) : []
    @booked_activity_ids.include?(id)
  end

  def academic_year(y)
    "a.a. #{y}/#{y.to_i + 1}"
  end

  def possible_label(_label, _txt)
    return "" if _txt.blank?
    "#{_label}: #{_txt}"
  end

  def sofia_link(a)
    a.sofia ? link_to("iscrizioni disponibili su S.O.F.I.A.", SOFIA_LINK) : ""
  end
end
