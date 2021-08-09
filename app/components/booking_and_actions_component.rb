# frozen_string_literal: true

class BookingAndActionsComponent < ViewComponent::Base
  def initialize(what:, user:)
    @what = what
    @user = user
    @booking = @user ? what.bookings.where(user_id: @user.id).first : nil
  end
end

