class TravelTaskComment < ApplicationRecord
  belongs_to :customer
  belongs_to :travel_task
  
  validates :content, presence: { message: "を入力してください" }
  validates :content,    length: { minimum: 1 }    
end
