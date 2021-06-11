# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Airline.destroy_all
Flight.destroy_all
Passenger.destroy_all
Manifest.destroy_all

@jetblue = Airline.create!(name: "JetBlue")
@flight1 = @jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
@flight2 = @jetblue.flights.create!(number: "3451", date: "08/05/20", departure_city: "San Francisco", arrival_city: "Seattle")
@flight3 = @jetblue.flights.create!(number: "9876", date: "08/15/20", departure_city: "New York JFK", arrival_city: "Portland")

@frontier = Airline.create!(name: "Frontier")
@flight4 = @frontier.flights.create!(number: "3567", date: "09/03/20", departure_city: "Santa Fe", arrival_city: "Las Vegas")
@flight5 = @frontier.flights.create!(number: "9872", date: "09/05/20", departure_city: "Los Angeles", arrival_city: "Miami")
@flight6 = @frontier.flights.create!(number: "2341", date: "09/15/20", departure_city: "Chicago", arrival_city: "Houston")

@pass1a = Passenger.create!(name: "Joe", age: 7)
Manifest.create(passenger: @pass1a, flight: @flight1)
@pass1b = Passenger.create!(name: "Sam", age: 23)
Manifest.create(passenger: @pass1b, flight: @flight1)
@pass1c = Passenger.create!(name: "Lin", age: 76)
Manifest.create(passenger: @pass1c, flight: @flight1)

@pass2a = @flight2.passengers.create!(name: "Jill", age: 98)
@pass2b = @flight2.passengers.create!(name: "Tan", age: 66)
@pass2c = @flight2.passengers.create!(name: "Rosa", age: 35)

@pass3a = @flight3.passengers.create!(name: "Phil", age: 45)
@pass3b = @flight3.passengers.create!(name: "Jan", age: 23)

@pass4a = @flight4.passengers.create!(name: "Lill", age: 67)
@pass4b = @flight4.passengers.create!(name: "Han", age: 12)

@pass5a = @flight5.passengers.create!(name: "Jill", age: 80)
@pass5b = @flight5.passengers.create!(name: "Tan", age: 36)

@pass6a = @flight6.passengers.create!(name: "Mill", age: 9)
@pass6b = @flight6.passengers.create!(name: "Ban", age: 6)
