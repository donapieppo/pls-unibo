class UserPolicy < ApplicationPolicy
  def show?
    @user && ((@user == @record) || @user.staff?)
  end

  def edit?
    @user && @user.staff?
  end

  def update?
    @user && ((@user == @record) || @user.staff?)
  end

  def me?
    @user
  end

  def myedit?
    @user
  end
end
