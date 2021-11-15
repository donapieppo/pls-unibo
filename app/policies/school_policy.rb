class SchoolPolicy < ApplicationPolicy
  def index?
    @user && @user.staff
  end
end

