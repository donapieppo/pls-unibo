module ContactConcern
  extend ActiveSupport::Concern

  def choose_contact
    @what = @project || @edition || @event
    if params[:as_speaker]
      @url = [:add_speaker, @what]
    else
      @url = [:add_contact, @what]
    end
    @contacts = Contact.where.not(id: @what.contact_ids).order(:name)
    render 'contacts/choose_contact'
  end

  def add_contact
    @what = @project || @edition || @event
    @contact = Contact.find(params[:contact_id])
    @what.contacts << @contact
    redirect_to [:edit, @what]
  end

  def add_speaker
    @what = @edition || @event
    @contact = Contact.find(params[:contact_id])
    @what.speakers << @contact
    redirect_to [:edit, @what]
  end
end
