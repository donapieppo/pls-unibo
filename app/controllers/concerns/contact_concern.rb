module ContactConcern
  extend ActiveSupport::Concern

  def choose_contact
    @what = @project || @edition || @event
    @url = [:add_contact, @what]
    @contacts = Contact.where.not(id: @what.contact_ids).order(:name)
    render 'contacts/choose_contact'
  end

  def add_contact
    @what = @project || @edition || @event
    @contact = Contact.find(params[:contact_id])
    @what.contacts << @contact
    redirect_to [:edit, @what]
  end
end
