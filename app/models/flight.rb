class Flight < ApplicationRecord
  belongs_to :airline
  has_many :manifests, dependent: :destroy
  has_many :passengers, through: :manifests

  def airline_name
    airline.name
  end

  def self.unique_adult_passengers
    joins(:passengers)
    .select('flights.*, passengers.name as passenger_name, passengers.age as passenger_age')
    .where('passengers.age >= ?', 18)
    .distinct
  end
end
