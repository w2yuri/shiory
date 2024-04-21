class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: { message: "を入力してください" }

  has_many :post_images, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :travel_task_comments, dependent: :destroy
  # DM機能
  has_many :customer_chat_rooms
  has_many :chats
  # 多対多の関係を持つモデル間でのデータのやり取りできるようにする
  has_many :rooms, through: :customer_rooms

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # フォローしたときの処理
  def follow(customer)
    relationships.create(followed_id: customer.id)
  end
  # フォローを外すときの処理
  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end
  
  # 検索機能
  def self.search_for(content)
      Customer.where('name LIKE ?', '%' + (content || '') + '%')
  end

  # ゲストログイン用
  GUEST_CUSTomer_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_CUSTomer_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end

  # is_activeがfalseならfalseを返す(退会処理)
  def active_for_authentication?
    super && is_active
  end

  # 画像
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

end