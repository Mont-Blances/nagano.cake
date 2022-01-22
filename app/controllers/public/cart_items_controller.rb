class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
     @cart_item = current_customer.cart_items.new(cart_item_params)
    if @cart_item.quantity.nil?
      flash[:alert] = '数量を選択して下さい'
      redirect_to request.referer and return
    end

    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if @cart_item.present?
      @cart_item.quantity += params[:cart_item][:quantity].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.save
      redirect_to cart_items_path, notice: '商品を追加しました'
    else
      flash[:alert] = '商品を追加できませんでした。1回の注文は10個までです。'
      redirect_to request.referer
    end
  end


  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: '数量を変更しました'
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "カートの商品を削除しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    # cart_items.where(customer_id: current_customer.id).destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:notice] = "カートの商品を全て削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
  end


end
