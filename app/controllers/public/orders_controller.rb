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
      if Delivery.exists?(name: params[:order][:delivery_id])
  # registered は viwe で定義しています
        @order.name = Delivery.find(params[:order][:delivery_id]).name
        @order.address = Delivery.find(params[:order][:delivery_id]).address
      else
        redirect_to action: 'new'
  # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
      end
    elsif params[:order][:address_option] == "3"
  # view で定義している adress が"3"だったときにこの処理を実行します
      delivery_new = current_customer.Delivery.new(address_params)
      if delivery_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
      else
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
   @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "注文情報を確定しました"
     redirect_to orders_path
    else
      flash[:alart] = "入力内容をご確認ください"
      render :new
    end
  end

  def thank
  end


  def index
  end

  def show
  end

  def order_params
      params.require(:order).permit(:customer_id, :postcode, :address, :destination, :billing_amount, :payment_method, :order_status, :postage)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

end
