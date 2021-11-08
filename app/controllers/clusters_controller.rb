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
      render action: :new
    end
  end

  def show
  end

  def edit
    @activities = Activity.clusterable
  end

  def update
    @cluster.update(activity_ids: params[:cluster][:activity_ids],
                    name: params[:cluster][:name])
    redirect_to clusters_path
  end

  def destroy
    @cluster.delete
    redirect_to clusters_path
  end

  private 

  def set_cluster_and_authorize
    @cluster = Cluster.find(params[:id])
    authorize @cluster
  end
end
