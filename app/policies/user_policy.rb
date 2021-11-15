class UserPolicy < ApplicationPolicy
  def index
    @user && @user.master_of_universe?
  end

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

  def forget_form?
    forget?
  end

  def forget?
    @user
  end
end
