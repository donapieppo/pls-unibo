module ContactHelper
  def contacts_to_s(contacts)
    contacts.each do |contact|
      concat(mail_to(contact.email, contact.name) + " <small>(".html_safe + contact.email + ")</small>".html_safe)
    end
  end
end
