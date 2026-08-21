class PassengerMailer < ApplicationMailer
  default from: "bookings@example.com"

  def booking_confirmation
    @passenger = params[:passenger]
    @booking = @passenger.booking

    mail(
      to: @passenger.email,
      subject: "You have booked your ticket"
    )
  end
end
