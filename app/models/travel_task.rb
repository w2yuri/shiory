class TravelTask < ApplicationRecord
  # coccon用の記述
  belongs_to :post
  has_many :travel_task_comments, dependent: :destroy

  has_one_attached :task_image
  
  validates :title, :contents, presence: { message: "を入力してください" }
  validates :title, :contents,    length: { minimum: 1 }   
  
  
  # 代替画像
  def get_task_image(width, height)
    unless task_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      task_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
   task_image.variant(resize_to_limit: [width, height]).processed
  end
  
end