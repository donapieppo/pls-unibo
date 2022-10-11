require "test_helper"

class BookingOnlineTest < ActiveSupport::TestCase
  test "activity ONLY on line do not permit create booking in presence" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: true, in_presence: false)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added? :base, :not_in_presence
  end

  test "activity ONLY in presence do not permit create booking online" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: false, in_presence: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: true)
    assert_not b.valid?
    assert b.errors.added? :base, :not_online
  end

  test "activity on line AND in presence with online booking" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: true, in_presence: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: true)
    b.valid?
  end

  test "activity on line AND in presence with inpresence booking" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, online: true, in_presence: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u, online: false)
    assert b.valid?
  end
end
