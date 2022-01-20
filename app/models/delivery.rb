class Delivery < ApplicationRecord

  validates :postcode, presence: true
  validates :address, length: {minimum: 7}, presence: true
  validates :destination, presence: true

   belongs_to :customer



end
