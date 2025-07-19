class FlightsController < ApplicationController
  def index
    @airports = Airport.all

    # Efficiently gather unique flight dates (sorted)
    @available_dates = Flight.distinct
                             .pluck(:start_datetime)
                             .map(&:to_date)
                             .uniq
                             .sort

    # If all 3 search inputs are present
    if params[:departure_airport_id].present? &&
       params[:arrival_airport_id].present? &&
       params[:date].present?

      # Prevent invalid searches where departure == arrival
      if params[:departure_airport_id] == params[:arrival_airport_id]
        flash.now[:alert] = "Departure and arrival airports must be different."
        @flights = []
      else
        date = Date.parse(params[:date])

        @flights = Flight.where(
          departure_airport_id: params[:departure_airport_id],
          arrival_airport_id: params[:arrival_airport_id]
        ).where(start_datetime: date.beginning_of_day..date.end_of_day)
      end
    else
      @flights = []
    end
  end
end
