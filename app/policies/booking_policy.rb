class BookingPolicy < ApplicationPolicy
  def create?
    @user && @record.activity.bookable_now? 
  end

  def new_user?
    @user && @user.confirmed_teacher?
  end
end
