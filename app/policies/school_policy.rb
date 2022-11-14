class SchoolPolicy < ApplicationPolicy
  def index?
    @user && @user.staff
  end

  def select_in_province?
    @user
  end
end
