require "test_helper"

class Bookability::InfoFreeSeatsTest < ViewComponent::TestCase
  test "bookable = yes in dates with not today => free seats" do
    edition = FactoryBot.create(:edition, bookable: 'yes', seats: 10, booking_start: Date.yesterday, booking_end: Time.now - 1.hour, bookable_by_all: true)
    render_inline Bookability::InfoComponent.new(edition)
    assert_text "10 posti liberi in presenza su 10"
  end

  test "bookable = yes in dates with today => posti esauriti" do
    edition = FactoryBot.create(:edition, bookable: 'yes', booking_start: Date.yesterday, booking_end: Date.tomorrow, bookable_by_all: true)
    render_inline Bookability::InfoComponent.new(edition)
    assert_text "posti in presenza esauriti"
  end
end
