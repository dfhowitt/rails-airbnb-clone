class Service < ApplicationRecord
  has_many :property_services, dependent: :destroy
  has_many :properties, through: :property_services
end
