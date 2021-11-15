class SchoolPolicy < ApplicationPolicy
  def index?
    @user && @user.staff
    true
  end
end

