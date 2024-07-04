class Review < ApplicationRecord
  belongs_to :tourist_spot
  belongs_to :user
  
  validates :evaluation, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 1000 }

  after_save :update_tourist_spot_avg_evaluation
  after_destroy :update_tourist_spot_avg_evaluation

  private

  def update_tourist_spot_avg_evaluation
    tourist_spot.update_avg_evaluation!
  end
end