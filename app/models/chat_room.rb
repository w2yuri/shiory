class ChatRoom < ApplicationRecord
  has_many :customer_chat_rooms
  has_many :chats
end
