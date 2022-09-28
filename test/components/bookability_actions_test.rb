require "test_helper"

class BookabilityComponentTest < ViewComponent::TestCase
  #EXTERNAL
  test "external bookings don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'external', booking_url: 'http://example.com')
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text /[a-z]+/
  end

  test "bookings=yes have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text /[a-z]+/
  end
end

