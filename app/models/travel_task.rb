class TravelTask < ApplicationRecord
  # coccon用の記述
  belongs_to :post

  has_one_attached :task_image
  
  
end