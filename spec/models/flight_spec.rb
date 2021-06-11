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
    it '.unique_adult_passengers returns a list of passengers for a collection of flights' do
      @jetblue = Airline.create!(name: "JetBlue")
      @flight1 = @jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
      @flight2 = @jetblue.flights.create!(number: "3451", date: "08/05/20", departure_city: "San Francisco", arrival_city: "Seattle")
      @flight3 = @jetblue.flights.create!(number: "9876", date: "08/15/20", departure_city: "New York JFK", arrival_city: "Portland")

      @pass1a = @flight1.passengers.create!(name: "Joe", age: 37)
      @pass1b = @flight1.passengers.create!(name: "Timmy", age: 12)
      @pass2a = @flight2.passengers.create!(name: "Jill", age: 98)
      @pass2b = @flight2.passengers.create!(name: "Little John", age: 17)
      @pass3a = @flight3.passengers.create!(name: "Phil", age: 45)

      #duplicate passengers
      Manifest.create!(flight: @flight1, passenger: @pass2a)
      Manifest.create!(flight: @flight3, passenger: @pass2a)

      output = @jetblue.flights.unique_adult_passengers
      expect(output.pluck(:id).length).to eq(3)
      expect(output.order('passengers.age ASC').first.id).to eq(@pass1a.id)
      expect(output.order('passengers.age ASC').second.id).to eq(@pass3a.id)
      expect(output.order('passengers.age ASC').last.id).to eq(@pass2a.id)
    end
  end
end
