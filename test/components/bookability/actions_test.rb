require "test_helper"

class Bookability::ActionComponentTest < ViewComponent::TestCase
  # EXTERNAL
  test "external bookings don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'external', booking_url: 'http://example.com')
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  # NO DATES
  test "booking = yes without dates don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, 
                                          seats: 10, in_presence: true)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  # FINISHED
  test "booking = yes with booking_end = yesterday do not have 'iscriviti' link" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, 
                                          seats: 10, in_presence: true,
                                          booking_start: Date.today - 3.days, booking_end: Date.yesterday)
    result = render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_link 'iscriviti'
  end
end
