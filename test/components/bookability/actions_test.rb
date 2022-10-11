require "test_helper"

class Bookability::ActionComponentTest < ViewComponent::TestCase
  # EXTERNAL
  test "external bookings don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'external', booking_url: 'http://example.com')
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  test "booking = yes without dates don't have actions" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_text(/[a-z]+/)
  end

  test "booking = yes with booking_end = yesterday do not have 'iscriviti' link" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10, 
                                booking_start: Date.today - 3.days, booking_end: Date.yesterday)
    result = render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_link 'iscriviti'
  end

  test "booking = yes for student_secondary do not have 'iscriviti' link" do
    u = FactoryBot.create(:user, :student_university)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10,  
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_no_link 'iscriviti'
  end

  test "booking = yes for student_secondary have iscriviti for student_secondary" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, seats: 10, 
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_link 'iscriviti'
  end

  test "booking = to_confirm for student_secondary have prenota for student_secondary" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: 'to_confirm', bookable_by_student_secondary: true, seats: 10, 
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_link 'prenota'
  end

  test "booking = yes for class and remote and in presence event can not book a a class if not @seats > 0" do
    u = FactoryBot.create(:user, :student_secondary)
    edition = FactoryBot.create(:edition, bookable: yes, bookable_by_teacher: true, bookable_for_classes: treu, seats: 1, 
                                          booking_start: Date.yesterday, booking_end: Date.tomorrow)
    render_inline Bookability::ActionsComponent.new(edition, u)
    assert_link 'iscrivi'
  end
end
