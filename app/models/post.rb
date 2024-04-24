class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images
  # 通知機能
  include Notifiable
  has_many :notifications, as: :notifiable, dependent: :destroy
  after_create do
    records = user.followers.map do |follower|
      notifications.new(user_id: follower.id)
    end 
    Notification.import records 
  end
  
  def notification_message
    "フォローしている#{customer.name}さんが#{title}を投稿しました"
  end

  def notification_path
    post_path(self)
  end
  

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

  # 検索機能
  def self.search_for(content)
    word = "%#{content}%"
    # ポストタイトルかコンテンツに一致しているか確認
    posts = Post.where('title LIKE ?', word).or(Post.where('contents LIKE ?', word))
    # pluck=ヒットしたトラベルタスクのpost_idの値を配列に入れて返す
    post_ids = TravelTask.where('title LIKE ?', word).or(TravelTask.where('contents LIKE ?', word)).pluck(:post_id)
    # ids変数に37行目と39行目のidを足して、最後にpostとtravel_taskの重複分を削除した値を入れて返す
    ids = [posts.ids + post_ids].uniq
    Post.where(id: ids)
  end
end
