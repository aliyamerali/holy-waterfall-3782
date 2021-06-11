require 'rails_helper'

RSpec.describe 'Airlin Show Page', type: :feature do
  before :each do
    @jetblue = Airline.create!(name: "JetBlue")
    @flight1 = @jetblue.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @jetblue.flights.create!(number: "3451", date: "08/05/20", departure_city: "San Francisco", arrival_city: "Seattle")
    @flight3 = @jetblue.flights.create!(number: "9876", date: "08/15/20", departure_city: "New York JFK", arrival_city: "Portland")

    @pass1a = @flight1.passengers.create!(name: "Joe", age: 37)
    @pass1b = @flight1.passengers.create!(name: "Sam", age: 23)

    @pass2a = @flight2.passengers.create!(name: "Jill", age: 98)
    @pass2b = @flight2.passengers.create!(name: "Tan", age: 66)

    @pass3a = @flight3.passengers.create!(name: "Phil", age: 45)
    @pass3b = @flight3.passengers.create!(name: "Jan", age: 18)

    #duplicate passengers
    Manifest.create!(flight: @flight1, passenger: @pass2a)
    Manifest.create!(flight: @flight3, passenger: @pass2a)
    Manifest.create!(flight: @flight3, passenger: @pass1a)

    #non-adult passengers
    @pass1c = @flight1.passengers.create!(name: "Timmy", age: 12)
    @pass2c = @flight2.passengers.create!(name: "Little John", age: 17)

    visit "/airlines/#{@jetblue.id}"
  end

  it 'shows passengers that have flights on the airline' do
    expect(page).to have_content(@pass1a.name)
    expect(page).to have_content(@pass1a.age)
    expect(page).to have_content(@pass1b.name)
    expect(page).to have_content(@pass1b.age)
    expect(page).to have_content(@pass2a.name)
    expect(page).to have_content(@pass2a.age)
    expect(page).to have_content(@pass2b.name)
    expect(page).to have_content(@pass2b.age)
    expect(page).to have_content(@pass3a.name)
    expect(page).to have_content(@pass3a.age)
    expect(page).to have_content(@pass3b.name)
    expect(page).to have_content(@pass3b.age)
  end

  it 'does not show duplicate passengers' do
    expect(page).to have_content(@pass2a.name, count: 1)
  end

  it 'does not show passengers 17 and under' do
    expect(page).to_not have_content(@pass1c.name)
    expect(page).to_not have_content(@pass2c.age)
  end

  it 'shows passengers ordered by count of flights' do
    expect(@pass2a.name).to appear_before(@pass1a.name)
    expect(@pass1a.name).to appear_before(@pass3a.name)
  end
end
