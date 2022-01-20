class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  # new 画面から渡ってきたデータをユーザーに確認してもらいます
  def confirm
    @order = Order.new(order_params)
  # new 画面から渡ってきたデータを @order に入れます
    if params[:order][:address_option] == "1"
  # view で定義している adress が"1"だったときにこの処理を実行します
  # form_with で @order で送っているので、order に紐付いた adress となります。以下同様です
  # この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
      @order.destination = current_customer.family_name # @order の各カラムに必要なものを入れます
      @order.address = current_customer.address
    elsif params[:order][:address_option] == "2"
  # view で定義している adress が"2"だったときにこの処理を実行します
      if Delivery.exists?(id: params[:order][:delivery_id])
  # registered は viwe で定義しています
        @order.destination= Delivery.find(params[:order][:delivery_id]).destination
        @order.address = Delivery.find(params[:order][:delivery_id]).address
      else
        redirect_to action: 'new'
  # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
      end
    elsif params[:order][:address_option] == "3"
  # view で定義している adress が"3"だったときにこの処理を実行します
      delivery_new = current_customer.delivery.new(delivery_params)
      if delivery_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
       flash[:notice] = "注文内容をご確認ください"
      else
         flash[:alart] = "入力内容をご確認ください"
        redirect_to action: 'new'
  # ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    else
      redirect_to action: 'new' # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
    end
    @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_taxin_price }
  # 合計金額を出す処理です sum_price はモデルで定義したメソッドです
  end


  def create
  cart_items = current_customer.cart_items.all
# ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
  @order = current_customer.order.new(order_params)
# 渡ってきた値を @order に入れます
  if @order.save
# ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    cart_items.each do |cart|
# 取り出したカートアイテムの数繰り返します
# order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_details = OrderDetail.new
      order_details.item_id = cart.item_id
      order_details.order_id = @order.id
      order_details.order_quantity = cart.quantity
# 購入が完了したらカート情報は削除するのでこちらに保存します
      order_details.price = cart.item.price
# カート情報を削除するので item との紐付けが切れる前に保存します
      order_details.save
    end
    redirect_to orders_thank_path
    cart_items.destroy_all
# ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
  else
    @order = Order.new(order_params)
    render :new
  end
  end

  def thank
  end


  def index
  end

  def show
  end


private

  def order_params
      params.require(:order).permit(:customer_id, :postcode, :address, :destination, :billing_amount, :payment_method, :order_status, :postage)
  end

  def delivery_params
    params.require(:order).permit(:customer_id, :destination, :address , :postcode)
  end

end
