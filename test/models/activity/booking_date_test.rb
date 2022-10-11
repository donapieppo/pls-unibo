require "test_helper"

class Activity::BookingDateTest < ActiveSupport::TestCase
  test 'bookable = yes && booking_start < booking_end' do
    edition = FactoryBot.build(:edition, bookable: 'yes', 
                                         booking_start: Date.tomorrow ,
                                         booking_end: Date.today)
    assert_not edition.valid?
    assert edition.errors.added? :base, :wrong_date_order
  end

  test 'external bookings do not have dates' do
    edition = FactoryBot.build(:edition, bookable: 'external',
                                         booking_start: Date.today + 2.days,
                                         booking_end: Date.today + 4.days)
    edition.save
    assert_not edition.booking_start
    assert_not edition.booking_end
  end
end
