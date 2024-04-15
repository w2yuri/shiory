class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :message, presence: { message: "を入力してください" }
  validates :message,    length: { minimum: 1 }    
end
