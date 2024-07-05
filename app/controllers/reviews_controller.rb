class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_tourist_spot, only: [:new, :create]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_duplicate_review, only: [:create]

  def new
    @review = @tourist_spot.reviews.build
  end
  
  def create
    @review = @tourist_spot.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Review created!"
      redirect_to @tourist_spot
    else
      flash.now[:danger] = "Review creation failed."
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] = "Review updated!"
      redirect_back(fallback_location: @tourist_spot)
    else
      flash.now[:danger] = "Review update failed."
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Review deleted!"
    redirect_back(fallback_location: @tourist_spot)
  end

  private
  
  # 観光スポットを取得
  def set_tourist_spot
    @tourist_spot = TouristSpot.find(params[:tourist_spot_id])
  end

  # レビューを取得
  def set_review
    @review = Review.find(params[:id])
    @tourist_spot = @review.tourist_spot 
  end

  def review_params
    params.require(:review).permit(:evaluation, :comment)
  end
  
  # 複数レビュー防止メソッド
  def check_duplicate_review
    if Review.exists?(user_id: current_user.id, tourist_spot_id: @tourist_spot.id)
      flash[:danger] = "You can only write one review per post. You have already written a review for this post."
      redirect_to new_tourist_spot_review_path(@tourist_spot)
    end
  end
  
end
