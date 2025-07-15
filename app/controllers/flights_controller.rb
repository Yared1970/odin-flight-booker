# app/controllers/flights_controller.rb
class FlightsController < ApplicationController
  def index
    @airports = Airport.all

    if params[:departure_airport_id].present? && params[:arrival_airport_id].present? && params[:date].present?
      date = Date.parse(params[:date])
      @flights = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id],
        start_datetime: date.beginning_of_day..date.end_of_day
      )
    else
      @flights = []
    end
  end
end
