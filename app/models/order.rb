class Order < ApplicationRecord
  enum payment_method:{credit: 0,bank:1}
  enum order_status:{wait: 0, confirmation: 1, making: 2, preparation: 3, finish: 4}

   belongs_to :customer
   has_many :order_details, dependent: :destroy

  validates :customer_id, presence: true
  # validates :postcord
  validates :address, presence: true
  # validates :destination
  validates :payment_method, presence: true
#   validates :billing_amount, presence: true
end
