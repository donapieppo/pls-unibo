class BookingPolicy < ApplicationPolicy
  def index?
    @user && (@user.staff? || @user.voyeur?)
  end

  def create?
    @activity = @record.activity

    return false if (@record.online && !@activity.online)
    return false if (!@record.online && !@activity.in_presence)

    @user && @activity.bookable &&
             @activity.bookable != 'no' &&
             @activity.now_in_bookable_interval? &&
             @activity.bookable_by_user_role?(@user) &&
             (@record.online || (@activity.free_seats > 0 && !@activity.cluster_complete_for_user?(@user)))
  end

  # teachers can add students
  def new_user?
    create? && @user.confirmed_teacher?
  end
  
  def new_school_class?
    create? && @user.confirmed_teacher?
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

  def thankyou?
    true
  end
end
