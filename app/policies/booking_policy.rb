class BookingPolicy < ApplicationPolicy
  def create?
    @user
  end
end
