class Public::SearchesController < ApplicationController
  def item_search
    @genres = Genre.all
    @items = Item.all
    if params[:search].present?
      @items = @items.where('name LIKE?', "%#{params[:search]}%")
    else
      flash[:alert] = '検索する場合は文字を入力してください。'
      redirect_to request.referer
    end
  end
end
