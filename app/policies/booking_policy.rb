class BookingPolicy < ApplicationPolicy
  def index?
    @user && (@user.staff? || @user.voyeur?)
  end

  def create?
    @activity = @record.activity
    @activity.bookable_now? && @activity.bookable_by_user?(@user)
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

  def new_student?
    create_student?
  end

  def create_student?
    @user && @user.teacher?
  end

  # def anew?
  #   acreate?
  # end

  # def acreate?
  #   @record.activity.bookable_now?
  # end

  def thankyou?
    true
  end
end
