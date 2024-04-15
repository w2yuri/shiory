# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Ad.find_or_create_by!(email: "admin@example.com") do |a|
  a.password = ENV['ADMIN_PASSWORD']
end

# ユーザー
shiori = Customer.find_or_create_by!(email: "shiori@example.com") do |c|
  c.name = "栞"
  c.password = ENV['CUSTOMER_PASSWORD']
  c.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename:"sample-customer1.jpg")
end

# 投稿
post = Post.find_or_create_by!(title: "X県旅行") do |p|
  p.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  p.contents = "2泊3日のX県旅行に行ってきました！1日目は〇〇市へ、2日目と3日目は◎◎町へ行きました。"
  p.customer_id = shiori.id
end

TravelTask.find_or_create_by!(title: "和食屋△△") do |tt|
  tt.task_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  tt.contents = "蕎麦が有名なお店です。ランチの時間に訪問しましたが、夜は居酒屋になりメニューが変わるそうなので次は夜に訪問したいです！"
  tt.post_id = post.id
end

TravelTask.find_or_create_by!(title: "きつね") do |tt|
  tt.task_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  tt.contents = "和食屋△△の近くを散策していたら野生の狐に出会いました。冬の時期は運が良ければ見る事ができるそうです！"
  tt.post_id = post.id
end
