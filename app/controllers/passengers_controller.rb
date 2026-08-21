class PassengersController < ApplicationController
  def name
  end

  def email
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      PassengerMailer.with(passenger:passenger).booking_confirmation.deliver_later
      format.html {redirect_to booking_path(@passenger.booking), notice: "Passenger created successfully!" }

      format.json { render :show, status: :created, location: @passenger }

    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @passenger.errors, status: :unprocessable_entity }
    end
  end

     
  end

end
