class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport", foreign_key: "departure_airport_id"
  belongs_to :arrival_airport, class_name: "Airport", foreign_key: "arrival_airport_id"

  validates :departure_airport, presence: true
  validates :arrival_airport, presence: true
  validates :start_datetime, presence: true
  validates :flight_duration, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :upcoming, -> { where("start_datetime > ?", Time.current) }
  scope :past, -> { where("start_datetime <= ?", Time.current) }
end
