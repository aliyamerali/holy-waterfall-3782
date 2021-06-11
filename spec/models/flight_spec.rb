require 'rails_helper'

RSpec.describe Flight, type: :model do
  it {should belong_to :airline}
  it {should have_many :manifests}
  it {should have_many(:passengers).through(:manifests)}

  describe 'instance methods' do
    it '#airline_name returns the name of the airline for the given flight' do
      jetblue = Airline.create!(name: "JetBlue")
      flight = jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")

      expect(flight.airline_name).to eq(jetblue.name)
    end
  end

  describe 'class methods' do
    it '.unique_adult_passengers returns a list of passengers for a collection of flights sorted by no. flights taken' do
      @jetblue = Airline.create!(name: "JetBlue")
      @flight1 = @jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight2 = @jetblue.flights.create!(number: "3451", date: "08/05/20", departure_city: "San Francisco", arrival_city: "Seattle")
      @flight3 = @jetblue.flights.create!(number: "9876", date: "08/15/20", departure_city: "New York JFK", arrival_city: "Portland")

      @pass1a = @flight1.passengers.create!(name: "Joe", age: 37) #2 flights
      @pass1b = @flight1.passengers.create!(name: "Timmy", age: 12)
      @pass2a = @flight2.passengers.create!(name: "Jill", age: 98) # 3 flights
      @pass2b = @flight2.passengers.create!(name: "Little John", age: 17)
      @pass3a = @flight3.passengers.create!(name: "Phil", age: 45) # 1 flight

      #duplicate passengers
      Manifest.create!(flight: @flight1, passenger: @pass2a)
      Manifest.create!(flight: @flight3, passenger: @pass2a)
      Manifest.create!(flight: @flight2, passenger: @pass1a)

      output = @jetblue.flights.unique_adult_passengers
      expect(output.length).to eq(3)
      expect(output.first.id).to eq(@pass2a.id)
      expect(output.second.id).to eq(@pass1a.id)
      expect(output.last.id).to eq(@pass3a.id)
    end
  end
end
