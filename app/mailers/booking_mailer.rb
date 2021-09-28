class BookingMailer < ApplicationMailer
  def notify_registration(booking)
    @booking = booking
    @activity = booking.activity
    mail to: booking.email, reply_to: 'mat-pls@unibo.it', bcc: 'dipmat-supportoweb@unibo.it', subject: 'Registrazione evento PLS.'
  end
end
