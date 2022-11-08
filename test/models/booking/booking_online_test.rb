require "test_helper"

class BookingOnlineTest < ActiveSupport::TestCase
  test "activity ONLY on line do not permit create booking in presence" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: true, in_presence: false, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added? :base, :not_in_presence
  end

  test "activity ONLY in presence do not permit create booking online" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: false, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: true)
    assert_not b.valid?
    assert b.errors.added? :base, :not_online
  end

  test "activity on line AND in presence with online booking" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: true, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: true)
    assert b.valid?
  end

  test "activity on line AND in presence with inpresence booking" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, seats: 10, online: true, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: false)
    assert b.valid?
  end
end
