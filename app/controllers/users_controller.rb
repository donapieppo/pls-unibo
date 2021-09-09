class UsersController < ApplicationController
  def index
    authorize :user
    @users = User.order(:surname, :name).all
  end

  def show 
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def me
    @user = current_user
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
      if municipality
        @user.school_id = School.where(name: name, municipality: municipality).first.id
      end
    end
    if @user.update(user_params)
      redirect_to me_users_path, notice: 'I tuoi dati sono stati registrati'
    else
      render action: :myedit
    end
  end

  private

  def user_params
    permitted = [:name, :surname, :role, :school_type, :other_string]
    if current_user.staff?
      permitted << :email
    else
      params[:user].delete(:email) unless current_user.staff?
    end
    if params[:user][:school_type].blank? || params[:user][:role] == 'other'
      params[:user][:school_type] = nil 
    end

    params[:user].permit(permitted)
  end
end
