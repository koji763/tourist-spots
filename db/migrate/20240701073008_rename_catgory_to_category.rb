class RenameCatgoryToCategory < ActiveRecord::Migration[6.1]
  def change
    rename_column :categories, :catgory, :category
  end
end
