# frozen_string_literal: true

class BookingComponent < ViewComponent::Base
  def initialize(what:, user:, short: false)
    @what = what
    @user = user
    @short = short
    if @what.over?
      return ""
    end
    @user_booking = @user ? what.bookings.where(user_id: @user.id).first : nil
  end
end
