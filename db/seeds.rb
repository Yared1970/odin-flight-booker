# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb



# Create airports
Airport.create!(code: "SFO")
Airport.create!(code: "NYC")
Airport.create!(code: "LAX")
Airport.create!(code: "DEN")
Airport.create!(code: "ATL")

# Define departure and arrival codes for flights
departure_code = "SFO"
arrival_code = "NYC"

# Only create if departure and arrival are different
if departure_code != arrival_code
  Flight.create!(
    departure_airport: Airport.find_by(code: departure_code),
    arrival_airport: Airport.find_by(code: arrival_code),
    start_datetime: Time.parse("2025-08-01 09:00"),
    flight_duration: 360
  )
end


if "NYC" != "LAX"
  Flight.create!(
    departure_airport: Airport.find_by(code: "NYC"),
    arrival_airport: Airport.find_by(code: "LAX"),
    start_datetime: Time.parse("2025-08-02 14:00"),
    flight_duration: 370
  )
end

if "LAX" != "DEN"
  Flight.create!(
    departure_airport: Airport.find_by(code: "LAX"),
    arrival_airport: Airport.find_by(code: "DEN"),
    start_datetime: Time.parse("2025-08-03 07:30"),
    flight_duration: 120
  )
end

if "ATL" != "SFO"
  Flight.create!(
    departure_airport: Airport.find_by(code: "ATL"),
    arrival_airport: Airport.find_by(code: "SFO"),
    start_datetime: Time.parse("2025-08-04 16:45"),
    flight_duration: 300
  )
end
