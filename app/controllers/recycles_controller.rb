class RecyclesController < ApplicationController
  def destroy
    @recycle = Recycle.find(params[:id])
  end
end
