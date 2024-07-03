class TouristSpotsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_tourist_spot, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @tourist_spots = pagy(search_tourist_spots(search_params).order(created_at: :desc), items: 5)
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
    # 選択画像の削除
    if params[:tourist_spot][:remove_images]
      params[:tourist_spot][:remove_images].each do |blob_id|
        image = @tourist_spot.images.find_by(blob_id: blob_id)
        image&.purge
      end
    end
    
    # 新しい画像を追加
    new_images = params[:tourist_spot].delete(:images)
    
    if @tourist_spot.update(tourist_spot_params)
      if new_images
        total_images = @tourist_spot.images.count + new_images.count
          if total_images <= 5
            @tourist_spot.images.attach(new_images)
            flash[:success] = "Tourist spot has been updated."
            redirect_to @tourist_spot and return
          else
            flash.now[:danger] = 'You can only upload up to 5 images.'
            render :edit and return
          end
      end
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
    redirect_to user_path(current_user)
  end

  private

  def set_tourist_spot
    @tourist_spot = TouristSpot.find(params[:id])
  end

  def tourist_spot_params
    params.require(:tourist_spot).permit(:spot_name, :address, :explanation, :category_id, :usage_scene_id, :prefecture_id, images: [])
  end
  
  def search_params
    params.permit(:prefecture_id, :address, { category_ids: [] }, { usage_scene_ids: [] }, :sort)
  end
  
  def search_tourist_spots(params)
    spots = TouristSpot.all
    
    # 検索優先度1: 都道府県
    if params[:prefecture_id].present?
      spots = spots.where(prefecture_id: params[:prefecture_id])
    end
    
    # 検索優先度2: エリア
    if params[:address].present?
      spots = spots.where('address LIKE ?', "%#{params[:address]}%")
    end
    
    # 検索優先度3: カテゴリと使用シーン (OR条件)
    if params[:category_ids].present? && params[:usage_scene_ids].present?
      spots = spots.where(category_id: params[:category_ids]).or(spots.where(usage_scene_id: params[:usage_scene_ids]))
    elsif params[:category_ids].present?
      spots = spots.where(category_id: params[:category_ids])
    elsif params[:usage_scene_ids].present?
      spots = spots.where(usage_scene_id: params[:usage_scene_ids])
    end
    
    #並び替え
    case params[:sort]
      when 'newest'
        spots = spots.order(created_at: :desc)
      when 'highest_rating'
        spots = spots.order(avg_evaluation: :desc)
      else
        spots = spots.order(created_at: :desc) # デフォルトは最新順
    end

    spots
    
  end

  
end
