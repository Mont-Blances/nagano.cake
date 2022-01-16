class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params)
    @item.save
    redirect_to action: 'index'
  end

  def editing
    @item = Item.find(params[:id])
  end

  def updated
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to action: 'index'
  end

  private

  def item_params
    params.require(:item).permit(:name, :item_introduction, :price, :image)
  end
end