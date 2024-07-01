# Clear existing data
Category.destroy_all
UsageScene.destroy_all

# Add categories
categories = ["Food & Dining", "Accommodation", "Nature", "Cultural Sites", "Shopping", "Entertainment", "Others"]
categories.each do |category|
  Category.create!(category: category)
end

# Add usage scenes
usage_scenes = ["Family Friendly", "Romantic", "Solo Travel", "Group Travel"]
usage_scenes.each do |usage_scene|
  UsageScene.create!(usage_scene: usage_scene)
end

puts "Seeded categories and usage scenes."
