class EventPolicy < ActivityPolicy
  def book?
    BookingPolicy.new(@user, @record.bookings.new).create?
  end
end


