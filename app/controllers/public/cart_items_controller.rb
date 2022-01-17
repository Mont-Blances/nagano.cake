class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(params)
    @cart_item.save
    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
