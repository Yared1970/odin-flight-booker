class BookingsController < ApplicationController
  def new
    @flight = Flight.find_by(id: params[:flight_id])
    @passenger_count = params[:passengers].to_i

    if @flight.nil? || @passenger_count <= 0
      redirect_to root_path, alert: "Invalid flight or passenger count."
      return
    end

    @booking = Booking.new(flight: @flight)

    @passenger_count.times do
      @booking.passengers.build
    end
  end

  def create
  @booking = Booking.new(booking_params)

  if @booking.save
    @booking.passengers.each do |passenger|
      PassengerMailer.with(passenger: passenger)
                     .booking_confirmation
                     .deliver_now
    end

    redirect_to @booking
  else
    render :new, status: :unprocessable_entity
  end
end

  def show
    @booking = Booking.find(params[:id])
  end



  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      passengers_attributes: [ :name, :email ]
    )
  end
end
