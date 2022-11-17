class SchoolsController < ApplicationController
  def index
    authorize :school
    @school_types = School.school_types
    @provinces = School.provinces
    @schools = School.order(:name)
    if params[:school_types]
      @schools = @schools.where(school_type: params[:school_types])
    end
    if params[:provinces]
      @schools = @schools.where(province: params[:provinces])
    end
    unless params[:school_types] || params[:provinces]
      @schools = []
    end
  end

  def show
    @school = School.find(params[:id])
    authorize @school
  end

  def select_in_province
    authorize :school
    province = params[:p] ? params[:p].gsub(/[^A-Za-z\- ']/, '').upcase : 'NO'
    @schools = School.where(province: province).order(:name)
    render layout: false
  end
end
