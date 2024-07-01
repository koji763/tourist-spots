class CreateTouristSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :tourist_spots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :usage_scene, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true
      t.string :spot_name
      t.string :address
      t.text :explanation
      t.float :avg_evaluation

      t.timestamps
    end
  end
end
