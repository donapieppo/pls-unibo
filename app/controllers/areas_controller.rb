class AreasController < ApplicationController
  before_action :set_area_and_check_permission, only: %i[ edit update destroy ]

  def edit
  end

  def update
    if @area.update(area_params)
      redirect_to root_path, notice: 'OK'
    else
      render action: :edit
    end
  end

  private

  def set_area_and_check_permission
    @area = Area.find(params[:id])
    authorize @area
  end

  def area_params
    params[:area].permit(:description)
  end
end
