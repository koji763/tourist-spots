class TouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :usage_scene
  belongs_to :prefecture
  # 複数画像のアップ（imagesは任意設定文字）
  has_many_attached :images
  
  # お気に入り機能
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  # 各カラム必須設定
  validates :spot_name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :explanation, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: true
  validates :usage_scene_id, presence: true
  validates :prefecture_id, presence: true
  
  # 画像の設定
  validate :image_type, :image_size, :image_limit
  
  # 平均評価取得
  def update_avg_evaluation!
    if reviews.any?
      update(avg_evaluation: reviews.average(:evaluation).to_f)
    else
      update(avg_evaluation: nil)
    end
  end

  # 画像の形式・容量・枚数チェックメソッド
  private

  def image_type
    return unless images.attached?
    
    images.each do |image|
      unless image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:images, "must be a JPEG or PNG")
      end
    end
  end

  def image_size
    return unless images.attached?
    
    images.each do |image|
      if image.byte_size > 2.megabytes
        errors.add(:images, "should be less than 2MB")
      end
    end
  end

  def image_limit
    return unless images.attached?
    
    if images.size > 5
      errors.add(:images, "should not be more than 5")
    end
  end
  
end