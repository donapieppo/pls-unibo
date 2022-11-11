class UsersController < ApplicationController
  def index
    authorize :user
    @users = User.order(:surname, :name).includes(:school)
    if params[:role]
      @users = @users.where(role: params[:role])
    end
    if params[:staff]
      @users = @users.where(staff: true)
    end
  end

  def show 
    @user = User.find(params[:id])
    @bookings = @user.bookings
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def me
    @user = current_user
    @bookings = Booking.where('user_id = ? or teacher_id =?', @user.id, @user.id).includes(:activity).order('activities.name')
    authorize @user
    render action: :show
  end

  def myedit
    @user = current_user
    authorize @user
    render action: :edit
  end

  def update
    if current_user.staff?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    authorize @user
    if @user.update(user_params)
      redirect_to me_users_path, notice: 'I tuoi dati sono stati registrati.'
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def forget_form
    authorize :user
    @user = current_user
    if ! @user
      redirect_to root_path
    end
  end

  def forget
    authorize :user
    @user = current_user
    if @user
      @user.update!(name: "#{@user.id}Name", 
                    surname: "#{@user.id}Surname", 
                    email: "#{@user.id}@deleted-pls-unibo.it")
    end
    session[:user_id] = nil
    reset_session
    cookies.clear
    redirect_to root_path, notice: "Il suo account è stato cancellato come richiesto."
  end

  private

  def user_params
    # FIXME FIXME
    params[:user].delete(:role) if params[:user][:role].blank?
    permitted = [:name, :surname, :role, :school_id, :other_string]
    if current_user.staff?
      permitted << :email
    else
      params[:user].delete(:email) 
    end

    params[:user].permit(permitted)
  end
end
