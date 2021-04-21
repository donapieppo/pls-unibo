module ContactConcern
  extend ActiveSupport::Concern

  def choose_contact
    @what = @project || @edition || @event
    @url = [:add_contact, @what, as: params[:as]]
    @contacts = Contact.where.not(id: @what.contact_ids).order(:name)
    render 'contacts/choose_contact'
  end

  def add_contact
    @what = @project || @edition || @event
    @contact = Contact.find(params[:contact_id])
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
