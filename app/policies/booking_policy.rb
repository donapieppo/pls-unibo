class BookingPolicy < ApplicationPolicy
  def index?
    @user && @user.staff?
  end

  def create?
    return false unless @record.activity.bookable_now?

    if @user
      @user.teacher? || ! @record.activity.any_cluster_siblings_booked?(@user)
    else
      false
    end
  end

  # teachers can add students
  def new_user?
    @user && @user.confirmed_teacher?
  end

  def destroy?
    @user && (@user.id == @record.user_id || @user.id == @record.teacher_id || @user.staff?)
  end

  def confirm?
    @user && @user.staff?
  end

  def anew?
    acreate?
  end

  def acreate?
    @record.activity.bookable_now?
  end

  def thankyou?
    true
  end
end
