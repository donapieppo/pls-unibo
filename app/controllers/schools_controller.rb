class SchoolsController < ApplicationController
  def index
    authorize :school
    @schools = School.order(:name)
  end

  def show
    @school = School.find(params[:id])
    authorize @school
  end
end
