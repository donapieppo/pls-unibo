require "test_helper"

class BookabilityTest < ActiveSupport::TestCase
  test "external bookings don't have dates" do
    u = FactoryBot.create(:user)
    edition = FactoryBot.build(:edition)
    edition.bookable = 'external'
    edition.booking_start = Date.today + 2.days
    edition.booking_end = Date.today + 4.days
    edition.save
    assert_not edition.booking_start
  end
end
