class Passenger < ApplicationRecord
  has_many :manifests, dependent: :destroy
  has_many :flights, through: :manifests
end
