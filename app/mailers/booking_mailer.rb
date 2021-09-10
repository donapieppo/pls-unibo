class BookingMailer < ApplicationMailer
  def notify_registration(booking)
    mail subject: "Registrazione evento PLS"
  end
end
