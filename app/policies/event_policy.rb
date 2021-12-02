class EventPolicy < ActivityPolicy
  def show?
    @record.visible? || (@user && @user.staff?)
  end

  def book?
    BookingPolicy.new(@user, @record.bookings.new).create?
  end
end


