class FavoritesController < ApplicationController
  def index
    @places = Place.joins(:favorites).where(favorites: { user_id: current_user.id })
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        marker_html: render_to_string(partial: "marker", locals: { place: place })

      }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end

  def create

    @place = Place.joins(:favorites).find_by(favorites: { user_id: current_user.id })
    @favorite = Favorite.new(place: @place, user: current_user)

    # Inversion du statut du favori

    if @favorite
      @favorite.status = !@favorite.status
    else
      @favorite = current_user.favorites.new(place: @place, status: true)
    end

    if @favorite.save
      redirect_to favorites_path
    else
      render "favorites/index", status: :unprocessable_entity
    end
  end
end
