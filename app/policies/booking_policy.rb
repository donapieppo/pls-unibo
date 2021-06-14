class BookingPolicy < ApplicationPolicy
  def create?
    return false unless (@user && @record.activity.bookable_now?)

    ! @record.activity.any_cluster_siblings_booked?(@user)
  end

  def new_user?
    @user && @user.confirmed_teacher?
  end
end
