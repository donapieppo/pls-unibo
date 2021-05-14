class BookingPolicy < ApplicationPolicy
  def create?
    @user && @record.activity.bookable_now? 
  end
end
