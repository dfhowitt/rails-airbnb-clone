class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_many :property_services, dependent: :destroy
  has_many :services, through: :property_services
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
