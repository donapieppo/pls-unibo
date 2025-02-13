require "test_helper"

class Activity::FreeSeatsTest < ActiveSupport::TestCase
  test "external bookings do not have dates" do
    edition = FactoryBot.create(:edition,
      bookable: "yes", in_presence: true, bookable_by_all: true, seats: 10,
      booking_start: Date.yesterday, booking_end: Date.tomorrow)

    _booking = FactoryBot.create(:booking, :student_secondary_booking, activity: edition)

    # IS CACHE, neads reload
    edition = Edition.find(edition.id)
    assert_equal 9, edition.free_seats
  end
end
