class UserPolicy < ApplicationPolicy
  def edit?
    @user && @user.staff?
  end

  def update?
    @user && ((@user == @record) || @user.staff?)
  end

  def myedit?
    @user
  end
end
