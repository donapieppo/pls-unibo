require "test_helper"

class EditionTest < ActiveSupport::TestCase
  test "name uniqueness" do
    p1 = FactoryBot.create(:project)
    p2= FactoryBot.build(:project, name: p1.name)
    assert_not p2.valid?
  end
end

