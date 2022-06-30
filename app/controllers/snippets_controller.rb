class SnippetsController < ApplicationController
  before_action :set_edition, only: [:new, :create]
  before_action :set_snippet_and_check_permission, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @snippet = @edition.snippets.new
    authorize @snippet
  end

  def create 
    @snippet = @edition.snippets.new(snippet_params)
    authorize @snippet
    if @snippet.save
      redirect_to @edition
    else
      raise @snippet.errors.inspect
      render action: :new, status: :unprocessable_entity
    end
  end

  def edit
    @edition = @snippet.edition
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to edition_path(@snippet.activity_id)
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @snippet.destroy
    redirect_to [:edit, @snippet.edition]
  end

  private

  def set_edition
    @edition = Edition.find(params[:edition_id])
  end

  def snippet_params
    params[:snippet].permit(:name, :description)
  end

  def set_snippet_and_check_permission
    @snippet = Snippet.find(params[:id])
    authorize @snippet
  end
end
