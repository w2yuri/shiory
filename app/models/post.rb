class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images

  # cocoon用の記述
  has_many :travel_tasks, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :travel_tasks, reject_if: :all_blank, allow_destroy: true
  validates_associated :travel_tasks
  
end
