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

require 'time'

# Airports to use
airport_codes = %w[SFO NYC LAX DEN ATL]
airports = airport_codes.map { |code| Airport.find_or_create_by!(code: code) }

# Time settings
start_date = Date.today
end_date = start_date + 7.days
flight_hours = [ 6, 8, 10, 12, 14, 16, 18, 20, 22 ]  # Flights every ~2 hours

# Duration lookup (dummy values)
durations = {
  [ "SFO", "NYC" ] => 360,
  [ "SFO", "LAX" ] => 90,
  [ "NYC", "LAX" ] => 370,
  [ "LAX", "DEN" ] => 120,
  [ "ATL", "SFO" ] => 300,
  [ "DEN", "ATL" ] => 180,
  [ "NYC", "ATL" ] => 150,
  [ "ATL", "LAX" ] => 320
}

  # Create flights for each pair of airports, each day, at multiple times
  airport_codes.permutation(2).each do |from_code, to_code|
  from_airport = Airport.find_by(code: from_code)
  to_airport = Airport.find_by(code: to_code)
  duration = durations[[ from_code, to_code ]] || rand(90..400)

  (start_date..end_date).each do |date|
    flight_hours.each do |hour|
      start_time = Time.new(date.year, date.month, date.day, hour)

      Flight.create!(
        departure_airport: from_airport,
        arrival_airport: to_airport,
        start_datetime: start_time,
        flight_duration: duration
      )
    end
  end
end

puts "✅ Seeded many flights!"
