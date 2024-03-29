class BookingPolicy < ApplicationPolicy
  def index?
    @user && (@user.staff? || @user.voyeur?)
  end

  def create?
    @activity = @record.activity

    @user &&
      general_checks(@record, @activity) &&
      @activity.bookable_for_itsself?(@user) &&
      (@record.online || (@activity.free_seats > 0 && !@activity.cluster_complete_for_user?(@user)))
  end

  # teachers can add students
  def create_student?
    @activity = @record.activity

    @user &&
      general_checks(@record, @activity) &&
      @activity.bookable_for_students?(@user) &&
      (@record.online || @activity.free_seats > 0)
  end

  def new_student?
    create_student?
  end

  def create_school_class?
    @activity = @record.activity
    @user &&
      general_checks(@record, @activity) &&
      @activity.free_seats > 0 &&
      @activity.bookable_for_classes?(@user)
  end

  def new_school_class?
    create_school_class?
  end

  def create_school_group?
    @activity = @record.activity

    @user &&
      @user.bookings.where(activity_id: @record.activity_id).empty? &&
      general_checks(@record, @activity) &&
      @activity.free_seats > 0 &&
      @activity.bookable_for_groups?(@user)
  end

  def new_school_group?
    create_school_group?
  end

  def destroy?
    @user &&
      @record.activity.now_in_bookable_interval? &&
      (@user.id == @record.user_id || @user.id == @record.teacher_id || @user.staff?)
  end

  def confirm?
    @user&.staff?
  end

  def thankyou?
    true
  end

  private

  def general_checks(record, activity)
    return false if (record.online && !activity.online)
    return false if (!record.online && !activity.in_presence)

    activity.bookable && activity.bookable != "no" && activity.now_in_bookable_interval?
  end
end
