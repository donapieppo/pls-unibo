class ActivityPolicy < ApplicationPolicy
  def book?
    BookingPolicy.new(@user, @record.bookings.new).create?
  end
end
