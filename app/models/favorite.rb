class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  # 指定された属性の値が一意であること(いいねは１投稿につき１度のみ)
  validates_uniqueness_of :post_id, scope: :customer_id
end
