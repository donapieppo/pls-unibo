module ContactConcern
  extend ActiveSupport::Concern

  def choose_contact
    @what = @activity || @edition || @event
    @url = [:add_contact, @what]
    render 'contacts/add_contact'
  end

  def add_contact
    @what = @activity || @edition || @event
    @contact = Contact.find(params[:contact_id])
    @contact.contact_records.new(record_type: @what.class, record_id: @what.id).save
    redirect_to [:edit, @what]
  end
end
