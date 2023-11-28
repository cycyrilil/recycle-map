class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @place = Place.find(params[:place_id])
    @favorite.user_id = current_user
    @favorite.place = @place
    if @favorite.save
      @favorite.place = @place
      redirect_to place_path(@place)
    else
      render "actors/show", status: :unprocessable_entity
    end
  end
end
