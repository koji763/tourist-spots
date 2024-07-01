class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :tourist_spots, dependent: :destroy
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
  
end
