class Service < ApplicationRecord
  has_many :property_services
  has_many :properties, through: :property_services
end
