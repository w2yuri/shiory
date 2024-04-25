class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  # 通知機能
  # include Notifiable
  # has_one :notification, as: :notifiable, dependent: :destroy
  # after_create do
  #   create_notification(customer_id: post.customer_id)
  # end
  
  # def notification_message
  #   "投稿した#{post.title}が#{customer.name}さんにいいねされました"
  # end

  # def notification_path
  #   customer_path(customer)
  # end
  
  # 指定された属性の値が一意であること(いいねは１投稿につき１度のみ)
  validates_uniqueness_of :post_id, scope: :customer_id
end
