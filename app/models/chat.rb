class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :chat_room

  validates :message, presence: { message: "を入力してください" }
  validates :message, length: { in: 1..140 }

  # 通知機能
  include Notifiable
  has_one :notification, as: :notifiable, dependent: :destroy
  after_create do
    create_notification(customer_id: customer_id)
  end
end