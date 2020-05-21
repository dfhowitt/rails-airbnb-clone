class Review < ApplicationRecord
  belongs_to :booking, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
