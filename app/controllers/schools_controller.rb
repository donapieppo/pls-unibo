class SchoolsController < ApplicationController
  def index
    authorize :school
    @schools = School.order(:name)
  end

  def show
    @school = School.find(params[:id])
    authorize @school
  end

  def select_in_province
    authorize :school
    province = params[:p] ? params[:p].gsub(/[^A-Za-z- ']/, '').upcase : 'NO'
    @schools = School.where(province: province).order(:name)
    render layout: false
  end
end
