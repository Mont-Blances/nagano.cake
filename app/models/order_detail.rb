class OrderDetail < ApplicationRecord
  after_update :check_production_status

  enum production_status:{before: 0,wait:1,make:2,finish:3}

  belongs_to :order
  belongs_to :item

  private

  def check_production_status
    if self.production_status == "make"
      self.order.update(order_status: "making")
    elsif self.production_status == "finish"
      if self.order.order_details.all? { |order_detail| order_detail.production_status == "finish" }
        self.order.update(order_status: "preparation")
      end
    end
  end

end
