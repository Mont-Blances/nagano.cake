class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all

  end

  def create
    # binding.pry
    @cart_item = current_customer.cart_items.new(cart_item_params)

    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
      new_quantity = cart_item.quantity + @cart_item.quantity
      cart_item.update_attribute(:quantity, new_quantity)
      @cart_item.delete
      end
    end
    @cart_item.save
    redirect_back(fallback_location: root_path)
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: '数量を変更しました'
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    # cart_items.where(customer_id: current_customer.id).destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
  end


end
