module ContactConcern
  extend ActiveSupport::Concern

  def add_contact
    @what = @project || @edition || @event
    @contact = Contact.find_by_id(params[:contact_id])
    if !@contact
      redirect_to [:new, @what, :contact, as: params[:as]]
      return
    end
    if params[:as] == 'speaker'
      @what.speakers << @contact
    else
      @what.contacts << @contact
    end
    redirect_to [:edit, @what]
  end

  def remove_contact
    @what = @project || @edition || @event
    @contact = Contact.find(params[:contact_id])
    if params[:as] == 'speaker'
      @what.speakers.delete(@contact)
    else
      @what.contacts.delete(@contact)
    end
    redirect_to [:edit, @what]
  end
end
