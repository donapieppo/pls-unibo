class ContactsController < ApplicationController
  before_action :set_activity_and_check_permission, only: %i[ edit update destroy ]

  def index
    authorize :contact
    @contacts = Contact.order(:name)
  end

  def new
    @contact = Contact.new
    authorize @contact
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @contact
    if @contact.save
      redirect_to contacts_path, notice: 'OK'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: 'OK'
    else
      render action: :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path
  end

  private

  def set_activity_and_check_permission
    @contact = Contact.find(params[:id])
    authorize @contact
  end

  def contact_params
    params[:contact].permit(:name, :description, :email, :web_page)
  end
end
