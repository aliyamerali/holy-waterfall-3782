class Flight < ApplicationRecord
  belongs_to :airline
  has_many :manifests
  has_many :passengers, through: :manifests

  def airline_name
    airline.name
  end

end
