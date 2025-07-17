class FlightsController < ApplicationController
  def index
    @airports = Airport.all

    # Only collect dates from existing flights, and sort them
    @available_dates = Flight.select(:start_datetime)
                             .distinct
                             .map { |f| f.start_datetime.to_date }
                             .uniq
                             .sort

    if params[:departure_airport_id].present? &&
       params[:arrival_airport_id].present? &&
       params[:date].present?

      date = Date.parse(params[:date])

      @flights = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id]
      ).where(start_datetime: date.beginning_of_day..date.end_of_day)
    else
      @flights = []
    end
  end
end
