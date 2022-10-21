require "test_helper"

class Bookability::StudentSecondaryActionComponentTest < ViewComponent::TestCase
  setup do
    @user = FactoryBot.create(:user, :student_secondary)
    @edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_student_secondary: true, 
                                           seats: 10, in_presence: true, 
                                           booking_start: Date.yesterday, booking_end: Date.tomorrow)
  end

  test "booking = yes for student_secondary have iscriviti for student_secondary" do
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_link 'iscriviti'
  end

  test "booking = yes not for student_secondary do not have 'iscriviti' link" do
    @edition.bookable_by_student_secondary = false
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_no_link 'iscriviti'
  end

  test 'booking = to_confirm for student_secondary have prenota for student_secondary' do
    @edition.bookable = 'to_confirm'
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_link 'prenota'
  end
end
