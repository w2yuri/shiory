# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 【管理者】
# Admin.create!(
#   email: 'admin@admin',
#   password: 'adminadmin'

# ユーザー
栞 = Customer.find_or_create_by!(email: "shiori@example.com") do |customer|
  customer.name = "栞"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename:"sample-customer1.jpg")
end

# 投稿
Post.find_or_create_by!(post.title: "X県旅行") do |post|
  post.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.contents = "2泊3日のX県旅行に行ってきました！1日目は〇〇市へ、2日目と3日目は◎◎町へ行きました。"
  post.customer = 栞
end

TravelTask.find_or_create_by!(travel_task.title: "和食屋△△") do |travel_task|
  travel_task.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  travel_task.contents = "蕎麦が有名なお店です。ランチの時間に訪問しましたが、夜は居酒屋になりメニューが変わるそうなので次は夜に訪問したいです！"
  travel_task..customer = 栞
end

TravelTask.find_or_create_by!(travel_task.title: "きつね") do |travel_task|
  travel_task.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  travel_task.contents = "和食屋△△の近くを散策していたら野生の狐に出会いました。冬の時期は運が良ければ見る事ができるそうです！"
  travel_task..customer = 栞
end

# @post.title
# @post.contents
# @post.post_image

# travel_task.title
# travel_task.contents
# travel_task.task_image