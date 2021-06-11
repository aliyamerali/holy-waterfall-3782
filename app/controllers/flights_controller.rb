class FlightsController < ApplicationController

  def index
    @flights = Flight.all
  end

  def remove_passenger
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:pass_id])

    flight.passengers.delete(passenger)

    redirect_to '/flights'
  end
end
