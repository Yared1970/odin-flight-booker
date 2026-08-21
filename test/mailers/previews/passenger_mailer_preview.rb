# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  def booking_confirmation
       passenger = Passenger.first
       PassengerMailer.with(passenger: passenger).booking_confirmation.deliver_now
  end
end
