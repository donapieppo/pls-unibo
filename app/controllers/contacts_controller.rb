class ContactsController < ApplicationController
  before_action :set_what, only: %i[ new create ]
  before_action :set_activity_and_check_permission, only: %i[ edit update destroy ]

  def index
    authorize :contact
    @contacts = Contact.order(:name)
    if params[:area] == '1'
      @contacts = @contacts.left_joins(:areas).where('areas.id is not null')
    end
  end

  def new
    if @what
      @contact = @what.contacts.new
    else
      @contact = Contact.new
    end
    @as = params[:as]
    authorize @contact
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @contact
    if @contact.save
      if @what
        if params[:as] == 'speaker'
          @what.speakers << @contact
        else
          @what.contacts << @contact 
        end
        redirect_to [:edit, @what], notice: 'OK'
      else
        redirect_to contacts_path, notice: 'OK'
      end
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
    params[:contact].permit(:name, :description, :email, :web_page, :affiliation)
  end

  def set_what
    activity_id = params[:event_id] || params[:edition_id] || params[:project_id]
    @what = activity_id ? Activity.find(activity_id) : nil
  end
end
