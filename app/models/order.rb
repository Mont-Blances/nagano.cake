class Order < ApplicationRecord
  after_update :check_order_detail

  enum payment_method:{credit: 0,bank:1}
  enum order_status:{wait: 0, confirmation: 1, making: 2, preparation: 3, finish: 4}

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postcode,  presence: true
  validates :address, presence: true
  validates :destination, presence: true
  validates :payment_method, presence: true
  validates :billing_amount, presence: true

  def order_items_billing_amount
    (billing_amount - 800).round
  end

  private

   def check_order_detail
     if self.order_status == "confirmation"
       self.order_details.update_all(production_status: "wait")
     end
   end

end
