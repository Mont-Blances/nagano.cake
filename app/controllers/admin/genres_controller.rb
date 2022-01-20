class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
    redirect_to action: 'index'
    else
      flash[:alart] = "入力内容をご確認ください"
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを変更しました"
    redirect_to action: 'index'
    else
      flash[:alart] = "ジャンルを変更してください。"
      render :new
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
