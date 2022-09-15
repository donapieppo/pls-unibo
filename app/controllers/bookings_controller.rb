class BookingsController < ApplicationController
  #prepend_before_action :check_captcha, :check_privacy_policy, only: [:acreate] 
  before_action :set_activity, except: %i(index thankyou confirm destroy)
  before_action :set_booking_and_check_permission, only: %i(thankyou confirm, destroy)

  def index
    activity_id = (params[:activity_id] or params[:edition_id] or params[:event_id])

    @activity = activity_id ? Activity.find(activity_id) : nil
    @activities = activity_id ? [@activity] : Activity.order('start_date desc').with_bookings.bookable_undone
    @teacher_email = params[:temail] 
    @cluster = Cluster.find(params[:cluster]) if params[:cluster]

    authorize :booking

    respond_to do |format|
      format.html do  
      end
      format.csv do
        if @cluster
          bookings = Booking.find(@cluster.activities.map(&:booking_ids).flatten.uniq)
        elsif @activity
          bookings = @activity.bookings
        elsif @teacher_email
          bookings = Booking.where(teacher_email: @teacher_email).includes(:user, :activity)
        else
          bookings = []
        end
        send_data Booking.to_csv(bookings), filename: "prenotazioni.csv" 
      end
    end
  end

  def new
    unless current_user
      skip_authorization
      redirect_to root_path
      return
    end
    @free_seats = @activity.free_seats
    @booking = @activity.bookings.new(user_id: current_user.id)
    authorize @booking
    if @booking.missing_data?(:user)
      redirect_to myedit_users_path, alert: "Si prega di fornire i dati richiesti prima di iscriversi."
      return
    end
  end

  def new_student
    @free_seats = @activity.free_seats
    @booking = @activity.bookings.new(teacher_id: current_user.id)
    authorize @booking
    if @booking.missing_data?(:teacher)
      redirect_to myedit_users_path, alert: "Si prega di fornire i dati richiesti prima di iscriversi."
      return
    end
  end

  def new_school_class
    @free_seats = @activity.free_seats
    @booking = @activity.bookings.new(user_id: current_user.id, teacher_id: current_user.id)
    authorize @booking
  end

  def create
    @free_seats = @activity.free_seats
    @booking = @activity.bookings.new(booking_params)
    @booking.user_id = current_user.id
    authorize @booking

    if @booking.missing_data?(:user)
      redirect_to myedit_users_path, alert: "Si prega di inserire i propri dati prima di iscriversi."
      return
    end
    if @booking.save
      redirect_to @activity, notice: "Iscrizione registrata correttamente."
    else
      logger.info(@booking.errors.inspect)
      render action: :new, status: :unprocessable_entity
    end
  end

  # REFACTOR in model
  def create_student
    @user = User.find_by_email(params[:email])

    if @user == current_user
      skip_authorization
      redirect_to @activity, alert: "Non puoi registare te stesso come studente."
      return
    end

    @user ||= User.create(email: params[:email], 
                          name: params[:name], 
                          surname: params[:surname],
                          role: 'student_secondary', 
                          school_id: current_user.school_id)
    if @user
      @booking = @activity.bookings.new(user_id: @user.id, 
                                        teacher_id: current_user.id,
                                        teacher_name: current_user.name,
                                        teacher_surname: current_user.surname,
                                        teacher_email: current_user.email,
                                        seats: 1,
                                        notes: params[:notes])
      authorize(@booking)
      if @booking.save
        redirect_to [@activity, anchor: 'binfos'], notice: "Registrazione salvata."
      else
        @free_seats = @activity.free_seats
        render action: :new_student, status: :unprocessable_entity
      end
    else
      raise params.inspect
    end
  end

  def thankyou
    render layout: 'pages'
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
    elsif ! (current_user.confirmed_teacher? || current_user.staff?)
      params[:booking][:seats] = 1
      params[:booking].delete(:school_class)
    end
    params[:booking].permit(:email, :name, :surname, :role, :grade, :teacher_name, :teacher_surname, :teacher_email, :school_class,   
                            :other_string, :notes, :online, :seats)

    # if current user the model adds user data
    #if current_user
    #  { user_id: current_user.id, 
    #    notes: params[:booking][:notes],
    #    online: params[:booking][:online],
    #    seats: params[:booking][:seats] }
    #else
    #  logger.info("No current user")
    #  params[:booking].permit(:email, :name, :surname, :role, :school_type, :other_string, :notes, :online, :seats)
    #end
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

# anonymous
# def anew
#   @booking = @activity.bookings.new
#   if @activity.seats.to_i > 0
#     @free_seats = @activity.seats - @activity.bookings.count
#   end
#   authorize @booking
#   render layout: 'pages'
# end

# anonymous
# "booking"=>{"email"=>"donapieppo@yahoo.it", "name"=>"Pietro", "surname"=>"Donatini", "role"=>"teacher", "school_type"=>"secondo", "other_string"=>""}, "user"=>{"school_name"=>"GAUDENZIO FERRARI . MOMO -- MOMO"}
# def acreate
#   if Rails.env.development? || verify_recaptcha
#     if params[:user] && params[:user][:school_name]
#       name, municipality = params[:user][:school_name].split(" -- ")
#       if municipality
#         @school_id = School.where(name: name, municipality: municipality).first.id
#       end
#     end

#     @user = User.where(email: params[:booking][:email]).first
#     @user ||= User.create(email: params[:booking][:email],
#                           name: params[:booking][:name], 
#                           surname: params[:booking][:surname],
#                           school_id: @school_id,
#                           role: params[:booking][:role])

#     @booking = @activity.bookings.new(booking_params)

#     if @user.valid? && @activity.booked_by?(@user)
#       skip_authorization
#       redirect_to workshop21_path, alert: "Indirizzo email già registrato per questo evento in precedenza."
#     elsif @user.valid?
#       @booking.user_id = @user.id

#       authorize(@booking)
#       if @booking.save
#         BookingMailer.notify_registration(@booking).deliver_now
#         redirect_to thankyou_booking_path(@booking)
#       else
#         render action: :anew
#       end
#     else
#       @booking.validate
#       logger.info("User creation not valid")
#       skip_authorization
#       render action: :anew
#     end
#   else
#     skip_authorization
#     redirect_to workshop21_path, alert: "Verifica di google non corretta."
#   end
# end

