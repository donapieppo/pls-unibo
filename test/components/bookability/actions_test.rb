require "test_helper"

class Bookability::ActionComponentTest < ViewComponent::TestCase
  # EXTERNAL
  test "external bookings don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'external', booking_url: 'http://example.com')
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  test "bookings=yes without dates don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  test "bookings = yes for student_secondary do not have 'iscriviti' link" do
    u = FactoryBot.create(:user, :student_university)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10,  
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_link 'iscriviti'
  end

  test "bookings = yes for student_secondary have iscriviti for student_secondary" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10, 
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    result = render_inline Bookability::ActionsComponent.new(edition, u)
    assert_link 'iscriviti'
  end

  test "bookings = yes for student_secondary have prenota for student_secondary" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'to_confirm', bookable_by_student_secondary: true, seats: 10, 
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    result = render_inline Bookability::ActionsComponent.new(edition, u)
    assert_link 'prenota'
  end
end
