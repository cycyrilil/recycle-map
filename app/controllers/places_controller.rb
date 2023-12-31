class PlacesController < ApplicationController
  def index
    @places = Place.joins(:categories)
    if params[:address].present?
      @places = @places.near(params[:address], 10)
    end

    if params[:query].present?
      @query = ""
      params[:query].split(",").each_with_index do |query, index|
        @query += " OR " unless index == 0
        @query += "categories.name ILIKE '%#{query}%'"
      end

      @places = @places.where(@query)

    end

    # The `geocoded` scope filters only flats with coordinates
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    @user_marker = { marker_html: render_to_string(partial: "user_marker") }
  end

  def show
    @place = Place.find(params[:id])
  end
end
