class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :content, presence: { message: "を入力してください" }
  validates :content,    length: { minimum: 1 }    
end
