class ChatRoom < ApplicationRecord
  has_many :customer_rooms
  has_many :chats
end
