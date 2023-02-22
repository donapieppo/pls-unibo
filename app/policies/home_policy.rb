class HomePolicy < ApplicationPolicy
  def index?
    true
  end

  def report?
    @user && (@user.staff? || @user.voyeur?)
  end
end
