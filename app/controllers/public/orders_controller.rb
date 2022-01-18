class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  
  def confirm
  end
  
  def create
   @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "注文情報を確定しました"
     redirect_to orders_path
    else
      flash[:alart] = "入力内容をご確認ください"
      render :new
  end
    
  def index
  end

  def show
  end
  
def order_params
    params.require(:order).permit(:customer_id, :postcord, :address, :destination, :postcode, :billing_amount, :payment_method, :order_status)
end

end
