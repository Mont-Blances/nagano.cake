class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
   # view で定義している adress_option が"1"だったときにこの処理を実行します 
    if params[:order][:address_option] == "1"
   #destinationはorderの宛名のカラム名です。
      @order.destination = current_customer.family_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postcode = current_customer.postcode
   # view で定義している adress_option が"2"だったときにこの処理を実行します
    elsif params[:order][:address_option] == "2"
        Delivery.exists?(id: params[:order][:delivery_id])
        @order.destination= Delivery.find(params[:order][:delivery_id]).destination
        @order.address = Delivery.find(params[:order][:delivery_id]).address
        @order.postcode = Delivery.find(params[:order][:delivery_id]).postcode
   # view で定義している adress_option が"3"だったときにこの処理を実行します
    elsif params[:order][:address_option] == "3"
      delivery_new = current_customer.delivery.new(delivery_params)
      if delivery_new.save
       flash[:notice] = "注文内容をご確認ください"
      else
   #入力不足の場合は new に戻します
       flash[:alart] = "入力内容をご確認ください"
       redirect_to action: 'new'
      end
    end
    @cart_items = current_customer.cart_items.all
   # 合計金額を出す処理です sum_taxin_price はcart_itemモデルで定義したメソッドです
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_taxin_price }
  end


  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.order.new(order_params)
    if @order.save
    # order_details にもデータを保存します
      cart_items.each do |cart|
        order_details = OrderDetail.new
        order_details.item_id = cart.item_id
        order_details.order_id = @order.id
        order_details.order_quantity = cart.quantity
        order_details.price = cart.item.price
        order_details.save
      end
      redirect_to orders_thank_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def thank
  end

  def index
    @orders = current_customer.order.all
  end

  def show
    @order = Order.find(params[:id])
  end

private

  def order_params
      params.require(:order).permit(:customer_id, :postcode, :address, :destination, :billing_amount, :payment_method, :order_status, :postage)
  end

  def delivery_params
    params.require(:order).permit(:customer_id, :destination, :address , :postcode)
  end

end
