class FavoritesController < ApplicationController
  def index
    @places = Place.joins(:favorites).where(favorites: { user_id: current_user.id })
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        marker_html: render_to_string(partial: "marker", locals: { favorite: favorite }),
      }
    end
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
      #change le status de favoris + toggle
      if @favorite.status == false
        @favorite.status = true
      else
        @favorite.status = false
      end
      @favorite.place = @place
      redirect_to favorites_path(@place)
    else
      render "favorites/index", status: :unprocessable_entity
    end
  end
end
