class CreateUsageScenes < ActiveRecord::Migration[6.1]
  def change
    create_table :usage_scenes do |t|
      t.string :usage_scene

      t.timestamps
    end
  end
end
