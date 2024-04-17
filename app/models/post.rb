class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images

  validates :title, :contents, presence: { message: "を入力してください" }


  # cocoon用の記述
  has_many :travel_tasks, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :travel_tasks, reject_if: :all_blank, allow_destroy: true
  validates_associated :travel_tasks

   # 画像
  has_one_attached :post_image

  def get_task_image_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいね機能
  # 一致するレコードが存在しない＝createアクションへ
  # 一致するレコードが存在する＝destroyアクションへ
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  # 検索用
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + (content || '') + '%')
    end
  end

end
