class BookingsController < ApplicationController
  before_action :set_activity, except: [:index, :destroy]

  def index
    @bookiable_activities = Activity.bookable_now
    authorize :booking
  end

  def new
    @booking = @activity.bookings.new
    authorize @booking
  end

  def new_user
    @user = User.where(email: params[:email]).first

    if @user == current_user
      redirect_to @activity, notice: "Non puoi registare te stesso come studente."
      return
    end

    @user ||= User.create(email: params[:email], name: params[:name], surname: params[:surname])
    if @user
      booking = @activity.bookings.new(user_id: @user.id, teacher_id: current_user.id)
      authorize(booking)
      if booking.save
        redirect_to @activity, notice: "Registrazione salvata."
      else
        redirect_to @activity, alert: "NO. #{booking.errors.inspect}. #{params.inspect}"
      end
    else
      raise params.inspect
    end
  end

  def create
    @booking = @activity.bookings.new(booking_params)
    authorize @booking
    if @booking.save
      redirect_to @activity, notice: "Iscrizione corretta"
    else
      render action: :new
    end
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    authorize @booking
    @booking.delete
    redirect_to @booking.activity
  end

  private

  def set_activity
    @activity_id = params[:event_id] || params[:edition_id]
    @activity = Activity.find(@activity_id)
  end

  def booking_params
    if current_user
      { user_id: current_user.id }
    else
      params[:booking].permit(:name, :surname, :role, :school_type, :other_string)
    end
  end
end
