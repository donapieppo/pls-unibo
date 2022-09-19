class UsersController < ApplicationController
  def index
    authorize :user
    @users = User.order(:surname, :name).includes(:school)
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
    if school_name = params[:user].delete(:school_name)
      name, municipality = school_name.split(" -- ")
      school = School.where(name: name, municipality: municipality).first
      if municipality && school
        @user.school_id = school.id
      end
    end
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
    redirect_to logout_path
  end

  private

  def user_params
    # FIXME FIXME
    params[:user].delete(:role) if params[:user][:role] == ''
    permitted = [:name, :surname, :role, :school_city, :school_pec, :other_string]
    if current_user.staff?
      permitted << :email
    else
      params[:user].delete(:email) unless current_user.staff?
    end

    params[:user].permit(permitted)
  end
end
