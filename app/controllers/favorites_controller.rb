class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(status: false)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorite_path
  end

  def create
    @favorite = Favorite.new
    @favorite.place = Place.find(params[:place_id])
    @favorite.user = current_user
    if @favorite.save
      redirect_to favorites_path
    else
      render :new
    end
  end
end
