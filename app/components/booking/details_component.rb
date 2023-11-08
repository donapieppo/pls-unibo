# frozen_string_literal: true

class Booking::DetailsComponent < ViewComponent::Base
  def initialize(booking, current_user, deletable: false)
    @booking = booking
    @current_user = current_user
    @deletable = deletable
  end

  private

  def render?
    @booking.activity.this_academic_year?
  end
end
