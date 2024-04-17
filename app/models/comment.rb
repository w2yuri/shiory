class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :comment, presence: { message: "を入力してください" }
  validates :comment,    length: { minimum: 1 }    
end
