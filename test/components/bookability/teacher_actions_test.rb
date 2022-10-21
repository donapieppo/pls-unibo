require "test_helper"

class Bookability::ActionComponentTest < ViewComponent::TestCase
  setup do
    @user = FactoryBot.create(:user, :teacher)
    @edition = FactoryBot.create(:edition, bookable: 'yes', bookable_by_teacher: true, 
                                           seats: 10, in_presence: true, 
                                           booking_start: Date.yesterday, booking_end: Date.tomorrow)
  end

  test "booking = yes for teachert have iscriviti for teacher" do
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_link 'iscriviti'
  end

  test "booking = yes for student_secondary do not have 'iscriviti' link for teacher" do
    @edition.bookable_by_teacher = false
    @edition.bookable_by_student_secondary = false
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_no_link 'iscriviti'
  end

  test "booking = yes for students in presence event teacher can book a student" do
    @edition.bookable_by_teacher = false
    @edition.bookable_by_teacher_for_students = true
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_link @edition.booking_action_your_students_to_s
  end

  test "booking = yes for students in presence event teacher can not book a class if @seats = 0" do
    @edition.bookable_by_teacher = false
    @edition.bookable_by_teacher_for_students = true
    @edition.seats = 0
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_no_link @edition.booking_action_your_students_to_s
  end

  test "booking = yes for class in presence event can book a class" do
    @edition.bookable_by_teacher = false
    @edition.bookable_by_teacher_for_classes = true
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_link @edition.booking_action_class_to_s
  end

  test "booking = yes for class in presence event can not book a class if @seats = 0" do
    @edition.bookable_by_teacher = false
    @edition.bookable_by_teacher_for_classes = true
    @edition.seats = 0
    render_inline Bookability::ActionsComponent.new(@edition, @user)
    assert_no_link @edition.booking_action_class_to_s
  end
end
