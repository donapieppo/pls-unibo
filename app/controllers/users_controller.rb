class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    authorize @user
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
      redirect_to root_path, notice: 'OK'
    else
      render action: :edit
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
    params[:user].permit(permitted)
  end
end
