class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images

  # cocoon用の記述
  has_many :travel_tasks, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :travel_tasks, reject_if: :all_blank, allow_destroy: true
  validates_associated :travel_tasks
  
   # 画像
  has_one_attached :task_image
  # validate :contents_and_task_images_attached
  

  def get_task_image_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  private

  # def contents_and_task_image_attached
  #   unless contents.present? && task_image.attached?
  #     errors.add(:base, "contents and task_image must be attached")
  #   end
  # end
    
end
