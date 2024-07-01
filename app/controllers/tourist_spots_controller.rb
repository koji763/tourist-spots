class TouristSpotsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_tourist_spot, only: [:show, :edit, :update, :destroy]

  def index
  end
  
  def show
  end

  def new
    @tourist_spot = TouristSpot.new
  end

  def create
    @tourist_spot = current_user.tourist_spots.new(tourist_spot_params)
    if @tourist_spot.save
      flash[:success] = "Tourist spot has been created."
      redirect_to @tourist_spot
    else
      flash.now[:danger] = 'Failed to create tourist spot.'
      render :new
    end
  end

  def edit
  end

  def update
    if @tourist_spot.update(tourist_spot_params)
      flash[:success] = "Tourist spot has been updated."
      redirect_to @tourist_spot
    else
      flash.now[:danger] = 'Failed to update tourist spot.'
      render :edit
    end
  end

  def destroy
    @tourist_spot.destroy
    flash[:success] = "Tourist spot has been deleted."
    redirect_to tourist_spots_url
  end

  private

  def set_tourist_spot
    @tourist_spot = TouristSpot.find(params[:id])
  end

  def tourist_spot_params
    params.require(:tourist_spot).permit(:spot_name, :address, :explanation, :category_id, :usage_scene_id, :prefecture_id, images: [])
  end
  
end
