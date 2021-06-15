class SchoolsController < ApplicationController
  def show
    @school = School.find(params[:id])
    authorize @school
  end
end
