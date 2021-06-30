class BookingPolicy < ApplicationPolicy
  def create?
    return false unless @record.activity.bookable_now?

    if @user
      ! @record.activity.any_cluster_siblings_booked?(@user)
    else
      true
    end
  end

  def new_user?
    @user && @user.confirmed_teacher?
  end
end
