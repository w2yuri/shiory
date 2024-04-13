# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


管理者
# Admin.create!(
#   email: 'admin@admin',
#   password: 'adminadmin'

ユーザー
olivia = Customer.find_or_create_by!(email: "olivia@example.com") do |customer|
  customer.name = "Olivia"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename:"sample-customer1.jpg")
end

james = Customer.find_or_create_by!(email: "james@example.com") do |customer|
  customer.name = "James"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer2.jpg"), filename:"sample-customer2.jpg")
end

投稿
PostImage.find_or_create_by!(shop_name: "Cavello") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post_image.caption = "大人気のカフェです。"
  post_image.customer = olivia
end

PostImage.find_or_create_by!(shop_name: "和食屋せん") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post_image.caption = "日本料理は美しい！"
  post_image.customer = james
end



@post.title
@post.contents
@post.post_image


travel_task.title
travel_task.contents
travel_task.task_image