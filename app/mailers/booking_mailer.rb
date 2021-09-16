class BookingMailer < ApplicationMailer
  def notify_registration(booking)
    mail to: booking.email, subject: "Registrazione evento PLS"
  end
end
