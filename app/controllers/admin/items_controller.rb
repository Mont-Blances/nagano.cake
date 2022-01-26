class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

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
    @item = Item.new(item_params)
    if @item.save
      flash.now[:notice] = "商品を追加しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:alert] = "商品を追加できませんでした。"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash.now[:notice] = "編集内容を更新しました。"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "入力内容を確認してください。"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :item_introduction, :price, :image, :genre_id, :is_active)
  end
end