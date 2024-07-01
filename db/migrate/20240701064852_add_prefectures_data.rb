class AddPrefecturesData < ActiveRecord::Migration[6.1]
  def up
    prefectures = [
      "Hokkaido", "Aomori", "Iwate", "Miyagi", "Akita", "Yamagata", "Fukushima",
      "Ibaraki", "Tochigi", "Gunma", "Saitama", "Chiba", "Tokyo", "Kanagawa",
      "Niigata", "Toyama", "Ishikawa", "Fukui", "Yamanashi", "Nagano", "Gifu", "Shizuoka", "Aichi",
      "Mie", "Shiga", "Kyoto", "Osaka", "Hyogo", "Nara", "Wakayama",
      "Tottori", "Shimane", "Okayama", "Hiroshima", "Yamaguchi",
      "Tokushima", "Kagawa", "Ehime", "Kochi",
      "Fukuoka", "Saga", "Nagasaki", "Kumamoto", "Oita", "Miyazaki", "Kagoshima", "Okinawa"
    ]

    prefectures.sort.each do |name|
      Prefecture.create(prefecture: name)
    end
    
  end

  def down
    Prefecture.delete_all
  end

end
