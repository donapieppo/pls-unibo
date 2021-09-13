class BookingsController < ApplicationController
  #prepend_before_action :check_captcha, :check_privacy_policy, only: [:acreate] 
  before_action :set_activity, except: [:index, :confirm, :destroy]

  def index
    if params[:activity_id]
      @booked_activities = [Activity.find(params[:activity_id])]
    else
      @booked_activities = Activity.order('start_date desc').find(Booking.select(:activity_id).map(&:activity_id))
    end
    authorize :booking
  end

  def new
    @booking = @activity.bookings.new
    authorize @booking
  end

  # anonymous
  def anew
    @booking = @activity.bookings.new
    authorize @booking
    render layout: 'pages'
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
        redirect_to [:new, @activity, :booking], notice: "Registrazione salvata."
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

  # anonymous
  def acreate
    if Rails.env.development? || verify_recaptcha
      @user = User.where(email: params[:email]).first
      @user ||= User.create(email: params[:email], name: params[:name], surname: params[:surname])
      if @user
        booking = @activity.bookings.new(user_id: @user.id)
        authorize(booking)
        if booking.save
          raise BookingMailer.notify_registration(booking).inspect
          BookingMailer.notify_registration(booking).deliver_now
          redirect_to workshop21_path, notice: "Registrazione salvata."
        else
          redirect_to workshop21_path, alert: "NO. #{booking.errors.inspect}. #{params.inspect}."
        end
      else
        raise params.inspect
      end
    else
      skip_authorization
      redirect_to workshop21_path, alert: "Verifica di google non corretta."
    end
  end

  def confirm
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.confirm
      flash[:notice] = "Iscrizione confermata."
    end
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.destroy
      flash[:notice] = "Prenotazione cancellata"
    else
      flash[:alert] = "Errore"
    end
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
      params[:booking].permit(:name, :surname, :role, :school_type, :other_string, :notes)
    end
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end 
  end

  def check_privacy_policy
    unless params[:user][:privacy_policy] == 'true'
      self.resource = resource_class.new sign_up_params
      self.resource.errors[:privacy_policy] << 'Per proseguire è necessario accettare le condizioni.'
      respond_with_navigational(resource) { render :new }
    end
  end
end
