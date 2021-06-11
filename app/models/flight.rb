class Flight < ApplicationRecord
  belongs_to :airline
  has_many :manifests, dependent: :destroy
  has_many :passengers, through: :manifests

  def airline_name
    airline.name
  end

  def self.unique_adult_passengers
    joins(:passengers)
    .select('passengers.*, COUNT(flights.id) AS flight_count')
    .where('passengers.age >= ?', 18)
    .group('passengers.id')
    .order('flight_count DESC')
    .distinct
  end

end
