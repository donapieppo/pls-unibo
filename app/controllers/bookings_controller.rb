class BookingsController < ApplicationController
  before_action :set_activity

  def new
    @booking = @activity.bookings.new(user_id: current_user.id)
    authorize @booking
  end

  def new_user
    raise params.inspect
  end

  def create
    @booking = @activity.bookings.new(user_id: current_user.id)
    authorize @booking
    if @booking.save
      redirect_to @activity, notice: "Iscrizione corretta"
    else
      render action: :new
    end
  end

  private

  def set_activity
    @activity_id = params[:event_id] || params[:edition_id]
    @activity = Activity.find(@activity_id)
  end
end
