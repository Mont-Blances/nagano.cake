class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :desc)
    @item = Item.find(params[:id])
  end
  

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
