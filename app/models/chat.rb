class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :chat_room

  validates :message, presence: { message: "を入力してください" }
  validates :message, length: { in: 1..140 }

  # 通知機能
  include Notifiable
  has_one :notification, as: :notifiable, dependent: :destroy
  after_create do
    targets = chat_room.customer_chat_rooms.where(chat_room_id: chat_room.id).where.not(customer_id: customer_id)
    targets.each do |target|
      create_notification(customer_id: target.customer_id)
    end
  end
end