class Passenger < ApplicationRecord
  has_many :manifests
  has_many :flights, through: :manifests

end
