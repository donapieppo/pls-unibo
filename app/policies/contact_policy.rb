class ContactPolicy < ApplicationPolicy
  def index?
    @user && @user.staff?
  end
end
