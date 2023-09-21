class BookingsController < ApplicationController
  before_action :set_activity, except: %i[index thankyou confirm destroy]
  before_action :set_booking_and_check_permission, only: %i[thankyou confirm destroy]

  def index
    authorize :booking

    if params[:cluster_id]
      @cluster = Cluster.find(params[:cluster_id])
      @bookings = Booking.find(@cluster.activities.map(&:booking_ids).flatten.uniq)
    else
      activity_id = (params[:activity_id] or params[:edition_id] or params[:event_id])

      @activity = activity_id ? Activity.find(activity_id) : nil
      @activities = activity_id ? [@activity] : Activity.order("booking_start desc").with_bookings.bookable_undone
    end

    # TODO
    @teacher_email = params[:temail]

    respond_to do |format|
      format.html {}
      format.csv do
        bookings = if @cluster
                     @bookings
                   elsif @activity
                     @activity.bookings
                   elsif @teacher_email
                     Booking.where(teacher_email: @teacher_email).includes(:user, :activity)
                   else
                     []
                   end
        send_data Booking.to_csv(bookings), filename: "prenotazioni.csv"
      end
    end
  end

  def new
    @booking = @activity.bookings.new(user_id: current_user.id, online: (params[:online] or false))
    authorize @booking

    @free_seats = @activity.free_seats
    if @booking.missing_data?(:user)
      redirect_to myedit_users_path, alert: "Si prega di fornire i dati richiesti prima di iscriversi."
      return
    end
  end

  def new_student
    @booking = @activity.bookings.new(teacher_id: current_user.id, online: (params[:online] or false))
    authorize @booking

    @free_seats = @activity.free_seats
    if @booking.missing_data?(:teacher)
      redirect_to myedit_users_path, alert: "Si prega di fornire i dati richiesti prima di iscriversi."
      return
    end
  end

  def new_school_class
    @booking = @activity.bookings.new(user_id: current_user.id, teacher_id: current_user.id, online: false)
    authorize @booking

    @free_seats = @activity.free_seats
  end

  def new_school_group
    @booking = @activity.bookings.new(user_id: current_user.id, teacher_id: current_user.id, online: false)
    authorize @booking

    @free_seats = @activity.free_seats
  end

  def create
    @booking = @activity.bookings.new(booking_params)
    @booking.user_id = current_user.id
    authorize @booking

    @free_seats = @activity.free_seats
    if @booking.save
      redirect_to @activity, notice: "Iscrizione registrata correttamente."
    else
      logger.info(@booking.errors.inspect)
      render action: :new, status: :unprocessable_entity
    end
  end

  # REFACTOR in model
  def create_student
    if params[:booking][:email].blank? || params[:booking][:name].blank? || params[:booking][:surname].blank?
      skip_authorization
      redirect_to [:new_student, @activity, :bookings], alert: "È necessario inserire tutti i dati dello studente."
      return
    else
      @user = User.find_by_email(params[:booking][:email])
    end

    if @user == current_user
      skip_authorization
      redirect_to @activity, alert: "Non puoi registrare te stesso come studente."
      return
    end

    @user ||= User.create(
      email: params[:booking][:email],
      name: params[:booking][:name],
      surname: params[:booking][:surname],
      role: "student_secondary",
      school_id: current_user.school_id
    )

    if @user.id
      @booking = @activity.bookings.new(
        user_id: @user.id,
        teacher_id: current_user.id,
        teacher_name: current_user.name,
        teacher_surname: current_user.surname,
        teacher_email: current_user.email,
        online: params[:booking][:online],
        notes: params[:booking][:notes]
      )
      @booking.seats = @booking.online ? 0 : 1

      authorize(@booking)
      if @booking.save
        redirect_to [@activity, anchor: "binfos"], notice: "Registrazione salvata."
      else
        @free_seats = @activity.free_seats
        render action: :new_student, status: :unprocessable_entity
      end
    else
      raise params.inspect
    end
  end

  def create_school_class
    @booking = @activity.bookings.new(booking_params)
    @booking.user_id = current_user.id
    authorize @booking

    @free_seats = @activity.free_seats
    if @booking.save
      redirect_to @activity, notice: "Iscrizione registrata correttamente."
    else
      logger.info(@booking.errors.inspect)
      render action: :new_school_class, status: :unprocessable_entity
    end
  end

  def create_school_group
    @booking = @activity.bookings.new(booking_params)
    @booking.user_id = current_user.id
    @booking.school_group = true
    authorize @booking

    @free_seats = @activity.free_seats

    if @booking.save
      redirect_to @activity, notice: "Iscrizione registrata correttamente."
    else
      logger.info(@booking.errors.inspect)
      render action: :new_school_group, status: :unprocessable_entity
    end
  end

  def thankyou
    render layout: "pages"
  end

  def confirm
    if @booking.confirm
      flash[:notice] = "Iscrizione confermata."
    end
    redirect_to bookings_path
  end

  def destroy
    if @booking.destroy
      flash[:notice] = "Prenotazione cancellata"
    else
      flash[:alert] = "Errore"
    end
    redirect_to @booking.activity
  end

  private

  def set_booking_and_check_permission
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def set_activity
    @activity_id = params[:event_id] || params[:edition_id]
    @activity = Activity.find(@activity_id)
  end

  # only teacher can book more than one
  def booking_params
    if params[:booking][:online] == "1"
      params[:booking][:seats] = 0
    elsif !(current_user.confirmed_teacher? || current_user.staff?)
      params[:booking][:seats] = 1
      params[:booking].delete(:school_class)
    else
      # default seats
      params[:booking][:seats] = 1 unless params[:booking][:seats]
    end
    params[:booking].permit(
      :email, :name, :surname, :role, :grade, :teacher_name, :teacher_surname, :teacher_email, :school_class,
      :other_string, :notes, :online, :seats
    )
  end
end
