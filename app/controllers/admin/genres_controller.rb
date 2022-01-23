class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      flash.now[:notice] = "ジャンルを追加しました"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "入力内容をご確認ください"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash.now[:notice] = "ジャンルを変更しました"
    　redirect_to action: :index
    else
      flash.now[:alert] = "入力内容を確認してください。"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
