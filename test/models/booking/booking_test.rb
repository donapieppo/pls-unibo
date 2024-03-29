require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "user have to indicate role" do
    u = FactoryBot.create(:user)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added? :base, "Manca il ruolo del'utente"
  end

  test "student secondary have to indicate school" do
    u = FactoryBot.create(:user, :student_secondary, school: nil)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added?(:school_id, "Manca la scuola")
  end

  test "teacher have to indicate school" do
    u = FactoryBot.create(:user, :teacher, school: nil)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_teacher: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added?(:school_id, "Manca la scuola")
  end

  test "student_university have not to indicate school" do
    u = FactoryBot.create(:user, :student_university, school: nil)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_university: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert b.valid?
  end

  test "student have to indicate teacher" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert_not b.valid?
    assert b.errors.added?(:teacher_name, :blank)
  end

  test "teacher have not to indicate teacher" do
    u = FactoryBot.create(:user, :teacher)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_teacher: true)
    b = FactoryBot.build(:booking, activity: a, user: u, online: false)
    assert b.valid?
  end

  test "valid for student if complete" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.build(:booking, :data_complete, activity: a, user: u)
    assert b.valid?
  end

  test "valid for teacher even if not complete" do
    u = FactoryBot.create(:user, :teacher)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_teacher: true)
    b = FactoryBot.build(:booking, activity: a, user: u)
    assert b.valid?
  end

  test "unique for student" do
    u = FactoryBot.create(:user, :student_secondary)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_student_secondary: true)
    b = FactoryBot.create(:booking, :data_complete, activity: a, user: u)
    b2 = FactoryBot.build(:booking, :data_complete, activity: a, user: b.user)
    assert_not b2.valid?
    assert_includes 'Già prenotato questa attività.', b2.errors.messages_for(:base).first
  end

  test "unique for teacher for itsself" do
    u = FactoryBot.create(:user, :teacher)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_teacher: true)
    b = FactoryBot.create(:booking, :data_complete, activity: a, user: u)
    b2 = FactoryBot.build(:booking, :data_complete, activity: a, user: u)
    assert_not b2.valid?
    assert_includes 'Già prenotato questa attività.', b2.errors.messages_for(:base).first
  end

  test "not unique for teacher for itsself and class" do
    u = FactoryBot.create(:user, :teacher)
    a = FactoryBot.create(:edition, seats: 10, in_presence: true, bookable_by_teacher: true)
    b = FactoryBot.create(:booking, :data_complete, activity: a, user: u)
    b2 = FactoryBot.build(:booking, :data_complete, activity: a, user: u, school_class: 'IIa')
    assert b2.valid?
  end

  # test "not unique for teacher for itsself and student" do
  #   u = FactoryBot.create(:user, :teacher)
  #   s = FactoryBot.create(:user, :student_secondary)
  #   b = FactoryBot.create(:booking, :data_complete, user: u)
  #   b2 = FactoryBot.build(:booking, :data_complete, user: s, teacher_id: u.id, activity: b.activity)
  #   assert b2.valid?
  # end

  # test "not unique for teacher for itsself and student" do
  #   u = FactoryBot.create(:user, :teacher)
  #   s = FactoryBot.create(:user, :student_secondary)
  #   b = FactoryBot.create(:booking, :data_complete, user: u)
  #   b2 = FactoryBot.build(:booking, :data_complete, user: s, teacher_id: u.id, activity: b.activity)
  #   assert b2.valid?
  # end
end
