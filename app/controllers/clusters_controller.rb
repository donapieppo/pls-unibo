class ClustersController < ApplicationController
  before_action :set_cluster_and_authorize, only: [:show, :edit, :update, :destroy]

  def index
    @clusters = Cluster.order(:name).all
    authorize :cluster
  end

  def new
    @cluster = Cluster.new
    authorize @cluster
  end

  def create
    @cluster = Cluster.new(name: params[:cluster][:name])
    authorize @cluster
    if @cluster.save
      redirect_to [:edit, @cluster]
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def show
    # SONO EDITIONS
    @activities = @cluster.activities.order(:name)
  end

  def edit
    # FIXME
    # add already selected acivities (because of CURRENT_ACADEMIC_YEAR changes)
    @activities = Activity.where(academic_year: @cluster.academic_year).order(:name)
  end

  def update
    @cluster.update(cluster_params)
    redirect_to clusters_path
  end

  def destroy
    @cluster.delete
    redirect_to clusters_path
  end

  private

  def set_cluster_and_authorize
    @cluster = Cluster.includes(activities: :contacts).find(params[:id])
    authorize @cluster
  end

  def cluster_params
    if params[:cluster][:limited_activities_checkbox]
      params[:cluster].delete(:limited_activities_checkbox)
      if params[:cluster][:max_bookable_activities].to_i < 1
        params[:cluster][:max_bookable_activities] = nil
      end
    else
      params[:cluster][:max_bookable_activities] = nil
    end
    params[:cluster].permit(:slug, :name, :description, :academic_year, :details, :max_bookable_activities, activity_ids: [])
  end
end
