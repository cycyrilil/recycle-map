class PlacesController < ApplicationController
  def index
    @places = Place.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place }),
        marker_html: render_to_string(partial: "marker", locals: { place: place })
      }

    end
  end

  def show
    @place = Place.find(params[:id])
  end
end
