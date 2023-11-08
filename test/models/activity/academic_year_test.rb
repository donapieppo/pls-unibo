require "test_helper"

class Activity::AcademicYearTest < ActiveSupport::TestCase
  test "this_academic_year? is false for edition 2023" do
    edition = FactoryBot.create(:edition, academic_year: 2023)
    assert edition.this_academic_year?
  end

  test "this_academic_year? is false for edition 2021" do
    edition = FactoryBot.create(:edition, academic_year: 2021)
    assert_not edition.this_academic_year?
  end

  test "this_academic_year? is false for event in edition 2021" do
    edition = FactoryBot.create(:edition, academic_year: 2021)
    event = FactoryBot.create(:event, edition: edition)
    assert_not event.this_academic_year?
  end

  test "this_academic_year? is true for event in edition 2023" do
    edition = FactoryBot.create(:edition, academic_year: 2023)
    event = FactoryBot.create(:event, edition: edition)
    assert_not event.this_academic_year?
  end
end
