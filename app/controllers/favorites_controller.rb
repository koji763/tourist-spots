class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @spot = TouristSpot.find(params[:favorite_spot_id])
    current_user.add_favorite(@spot)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end  end

  def destroy
    @spot = TouristSpot.find(params[:favorite_spot_id])
    current_user.delete_favorite(@spot)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end
end
