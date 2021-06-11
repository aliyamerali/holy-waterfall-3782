require 'rails_helper'

RSpec.describe 'Flights Index Page', type: :feature do
  before :each do
    @jetblue = Airline.create!(name: "JetBlue")
    @flight1 = @jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @jetblue.flights.create!(number: "3451", date: "08/05/20", departure_city: "San Francisco", arrival_city: "Seattle")
    @flight3 = @jetblue.flights.create!(number: "9876", date: "08/15/20", departure_city: "New York JFK", arrival_city: "Portland")

    @frontier = Airline.create!(name: "Frontier")
    @flight4 = @frontier.flights.create!(number: "3567", date: "09/03/20", departure_city: "Santa Fe", arrival_city: "Las Vegas")
    @flight5 = @frontier.flights.create!(number: "9872", date: "09/05/20", departure_city: "Los Angeles", arrival_city: "Miami")
    @flight6 = @frontier.flights.create!(number: "2341", date: "09/15/20", departure_city: "Chicago", arrival_city: "Houston")

    @pass1a = @flight1.passengers.create!(name: "Joe", age: 7)
    @pass1b = @flight1.passengers.create!(name: "Sam", age: 23)
    @pass1c = @flight1.passengers.create!(name: "Lin", age: 76)

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

    visit "/flights"
  end

  it 'shows a list of all flight numbers' do
    expect(page).to have_content(@flight1.number)
    expect(page).to have_content(@flight2.number)
    expect(page).to have_content(@flight3.number)
    expect(page).to have_content(@flight4.number)
    expect(page).to have_content(@flight5.number)
    expect(page).to have_content(@flight6.number)
  end

  it 'shows the airline of each flight' do
    within(".flight-#{@flight1.id}") do
      expect(page).to have_content(@jetblue.name)
      expect(page).to_not have_content(@frontier.name)
    end

    within(".flight-#{@flight2.id}") do
      expect(page).to have_content(@jetblue.name)
      expect(page).to_not have_content(@frontier.name)
    end

    within(".flight-#{@flight3.id}") do
      expect(page).to have_content(@jetblue.name)
      expect(page).to_not have_content(@frontier.name)
    end

    within(".flight-#{@flight4.id}") do
      expect(page).to have_content(@frontier.name)
      expect(page).to_not have_content(@jetblue.name)
    end

    within(".flight-#{@flight5.id}") do
      expect(page).to have_content(@frontier.name)
      expect(page).to_not have_content(@jetblue.name)
    end

    within(".flight-#{@flight6.id}") do
      expect(page).to have_content(@frontier.name)
      expect(page).to_not have_content(@jetblue.name)
    end
  end

  it 'shows the names of each flights passengers' do
    save_and_open_page
    within(".flight-#{@flight1.id}") do
      expect(page).to have_content(@pass1a.name)
      expect(page).to have_content(@pass1b.name)
      expect(page).to have_content(@pass1c.name)
      expect(page).to_not have_content(@pass2a.name)
    end

    within(".flight-#{@flight2.id}") do
      expect(page).to have_content(@pass2a.name)
      expect(page).to have_content(@pass2b.name)
      expect(page).to have_content(@pass2c.name)
      expect(page).to_not have_content(@pass3a.name)
    end

    within(".flight-#{@flight3.id}") do
      expect(page).to have_content(@pass3a.name)
      expect(page).to have_content(@pass3b.name)
      expect(page).to_not have_content(@pass4a.name)
      expect(page).to_not have_content(@pass5a.name)
    end

    within(".flight-#{@flight4.id}") do
      expect(page).to have_content(@pass4a.name)
      expect(page).to have_content(@pass4b.name)
      expect(page).to_not have_content(@pass5a.name)
      expect(page).to_not have_content(@pass6a.name)
    end

    within(".flight-#{@flight5.id}") do
      expect(page).to have_content(@pass5a.name)
      expect(page).to have_content(@pass5b.name)
      expect(page).to_not have_content(@pass4a.name)
      expect(page).to_not have_content(@pass6a.name)
    end

    within(".flight-#{@flight6.id}") do
      expect(page).to have_content(@pass6a.name)
      expect(page).to have_content(@pass6b.name)
      expect(page).to_not have_content(@pass4a.name)
      expect(page).to_not have_content(@pass5a.name)
    end
  end
end
