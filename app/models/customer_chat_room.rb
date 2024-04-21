class CustomerChatRoom < ApplicationRecord
  belongs_to :customer
  belongs_to :room
end
