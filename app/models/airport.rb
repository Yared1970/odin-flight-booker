class Airport < ApplicationRecord
  has_many :departure_flights, class_name: "Flight", foreign_key: "departure_airport_id"
  has_many :arrival_flights, class_name: "Flight", foreign_key: "arrival_airport_id"

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  scope :with_flights, -> { joins(:departure_flights).or(joins(:arrival_flights)).distinct }

  def upcoming_departure_flights
    departure_flights.upcoming
  end

  def past_departure_flights
    departure_flights.past
  end

  def upcoming_arrival_flights
    arrival_flights.upcoming
  end

  def past_arrival_flights
    arrival_flights.past
  end
end
