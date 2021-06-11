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
end
