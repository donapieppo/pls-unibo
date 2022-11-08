require "test_helper"

class Bookability::InfoTest < ViewComponent::TestCase
  # EXTERNAL
  test "external bookings links to site" do
    edition = FactoryBot.create(:edition, bookable: 'external', booking_url: 'http://example.com')
    render_inline Bookability::InfoComponent.new(edition)
    assert_text "per le iscrizioni visitare il sito"
    assert_text "example.com"
  end

  # bookable = NO
  test "bookable = no => no render" do
    edition = FactoryBot.create(:edition, bookable: 'no')
    render_inline Bookability::InfoComponent.new(edition)
    assert_no_text /[a-z]+/
  end

  # bookable = YES ma no dates
  test "bookable = yes in dates with not today => no render" do
    edition = FactoryBot.create(:edition, bookable: 'yes')
    render_inline Bookability::InfoComponent.new(edition)
    assert_no_text(/[a-z]+/)
  end

  # bookable = YES
  test "bookable = yes in dates with not today => render" do
    edition = FactoryBot.create(:edition, bookable: 'yes', booking_start: Date.yesterday, booking_end: Time.now - 1.hour, bookable_by_all: true)
    render_inline Bookability::InfoComponent.new(edition)
    assert_text "ISCRIZIONI APERTE"
  end

  test "bookable = yes in dates with today => render" do
    edition = FactoryBot.create(:edition, bookable: 'yes', booking_start: Date.yesterday, booking_end: Date.tomorrow, bookable_by_all: true)
    render_inline Bookability::InfoComponent.new(edition)
    assert_text "ISCRIZIONI APERTE"
  end
end
