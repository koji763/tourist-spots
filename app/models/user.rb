class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :tourist_spots, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  # お気に入り機能のためのモデル関連付け
  has_many :favorites, dependent: :destroy
  has_many :favorite_spots, through: :favorites, source: :tourist_spot
  
  # ActiveStorage
  has_one_attached :icon

  validate :acceptable_image
  
  # 画像ファイルの制約
  def acceptable_image
    return unless icon.attached?

    unless icon.byte_size <= 2.megabyte
      errors.add(:icon, "is too big. Must be less than 2MB")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(icon.content_type)
      errors.add(:icon, "must be a JPEG or PNG")
    end
  end
  
  # お気に入り登録・解除・確認
  def add_favorite(spot)
    self.favorites.find_or_create_by(tourist_spot_id: spot.id)
  end
  
  def delete_favorite(spot)
    favorite = self.favorites.find_by(tourist_spot_id: spot.id)
    favorite.destroy if favorite
  end
  
  def favorite?(spot)
    self.favorites.exists?(tourist_spot_id: spot.id)
  end
  
end
