class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
  end

  def show
  end
  
def order_params
    params.require(:order).permit(:customer_id, :postcord, :address, :destination, :postcode, :billing_amount, :payment_method, :order_status)
  end

end
