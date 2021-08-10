# frozen_string_literal: true

class BookingComponent < ViewComponent::Base
  def initialize(what:, user:)
    @what = what
    @user = user
    @user_booking = @user ? what.bookings.where(user_id: @user.id).first : nil
  end
end

