# Admin.create!(
#   email: 'admin@admin',
#   password: 'adminadmin'
# )

# # ユーザーを追加する
# Customer.create!(
#   [
#     {
#       email: 'tora@tora.com',
#       name: 'とら',
#       passwprd: 'toratora'
#       # image: File.open('./app/assets/images/tanuki.jpg')
#     },
#     {
#       email: 'kuma@kuma.com',
#       name: 'くま',
#       passwprd: 'kumakuma'
#       # image: File.open('./app/assets/images/kitune.jpg')
#     }
#   ]
# )

# Post.create!(
#   [
#     {
#       title: 'A件旅行',
#       contents: '桜が見頃の春に行くのがおすすめです！'
#     }
#   ]
# )

# customers_data.each do |data|
#   Customer.create!(data)
# end

# # ジャンルを追加する
# genres = ['ケーキ', 'クッキー', 'パイ', 'プリン', 'マカロン', 'チーズケーキ', 'タルト', 'ブラウニー', 'ドーナツ', 'アイスクリーム', 'パンケーキ', 'マフィン', 'ゼリー', 'シュークリーム', 'アップルパイ']

# genres.each do |genre_name|
#   Genre.create(name: genre_name)
# end


# # ジャンルIDの最小値と最大値を取得
# min_genre_id = Genre.minimum(:id)
# max_genre_id = Genre.maximum(:id)

# # 画像ファイル名の配列を用意（ここでは1から11までの数値を文字列にして用意）
# image_files = (1..11).map { |i| "image#{i}.jpg" }

# # 商品名の配列を用意
# cake_names = [
#   "チョコレートケーキ",
#   "ストロベリーショートケーキ",
#   "モンブラン",
#   "フルーツタルト",
#   "チーズケーキ",
#   "マーブルケーキ",
#   "抹茶ロールケーキ",
#   "ベリームースケーキ",
#   "シフォンケーキ",
#   "アップルパイ",
#   "パンナコッタ",
#   "タルトフロマージュ",
#   "ショコラケーキ",
#   "モンブランロール",
#   "ブルーベリーチーズタルト"
# ]

# # 15個の商品を作成
# 15.times do
#   # ランダムなジャンルID、画像ファイル、価格を選択
#   random_genre_id = rand(min_genre_id..max_genre_id)
#   random_image_file = image_files.sample
#   random_price = rand(1000..5000) # 価格は1000円から5000円の間でランダムに設定
#   random_item_name = cake_names.sample

#   # 商品のパラメータを作成
#   item_params = {
#     genre_id: random_genre_id,
#     name: random_item_name,
#     introduction: "美味しさが満載のケーキ！口の中でとろけるようなスポンジと濃厚なクリームが絶妙にマッチ。贅沢な一口で幸せを味わえます。",
#     price: random_price, # ランダムな価格
#     is_active: true, # 販売ステータス（true: 販売中, false: 販売停止）
#   }

#   # 画像をアタッチする
#   image_path = Rails.root.join('app', 'assets', 'images', random_image_file)
#   image = ActiveStorage::Blob.create_after_upload!(
#     io: File.open(image_path),
#     filename: random_image_file,
#     content_type: 'image/jpeg'
#   )

#   # 商品を作成し、画像をアタッチする
#   item = Item.new(item_params)
#   item.image.attach(image)
#   item.save!
# end




# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
