class BookingsController < ApplicationController
  before_action :set_activity_and_check_permission

  def new
    @booking = @activity.bookings.new(user_id: current_user.id)
  end

  def create
    @booking = @activity.bookings.new(user_id: current_user.id)
    if @booking.save
      redirect_to @activity, notice: "Iscrizione corretta"
    else
      render action: :new
    end
  end

  private

  def set_activity_and_check_permission
    @activity_id = params[:event_id] || params[:edition_id]
    @activity = Activity.find(@activity_id)
    skip_authorization
  end
end
