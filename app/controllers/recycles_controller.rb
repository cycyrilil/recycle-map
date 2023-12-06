class RecyclesController < ApplicationController
  def create
    @recycle = Recycle.new
    @user = current_user
    @place = Place.find(params[:place_id])
    @recycle.user = @user
    @recycle.place = @place

    if params[:category].present?
      params[:category].each do |category|
        RecycleCategory.create(category: Category.find_by(name: category), recycle: @recycle)
      end
    end
    if @recycle.save
      redirect_to place_recycles_path(@place)
    end
  end

  def destroy
    @recycle = Recycle.find(params[:id])
  end

end
