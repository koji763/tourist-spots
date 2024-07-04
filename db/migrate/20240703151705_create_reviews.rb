class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :tourist_spot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :evaluation
      t.text :comment

      t.timestamps
    end
  end
end
