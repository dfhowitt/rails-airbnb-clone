class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_one :review
end
