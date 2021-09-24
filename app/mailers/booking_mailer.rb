class BookingMailer < ApplicationMailer
  def notify_registration(booking)
    @booking = booking
    @activity = booking.activity
    mail to: booking.email, subject: "Registrazione evento PLS"
  end
end
