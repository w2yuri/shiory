class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers # モデルの中でxxx_pathメソッドを使用するために必要な記述になります。
 
  belongs_to :customer
  belongs_to :notifiable, polymorphic: true
  

  def message
    if notifiable_type === "Post"
      "フォローしている#{notifiable.customer.name}さんが#{notifiable.title}を投稿しました"
    else
      "投稿した#{notifiable.post.title}が#{notifiable.customer.name}さんにいいねされました"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Post"
      post_path(notifiable.id) # 投稿に対する通知の場合はPostの詳細ページへ
    else
      customer_path(notifiable.customer.id) # いいねに対する通知の場合はいいねをしたCustomerの詳細ページへ
    end
  end
  
  require 'active_support' # Railsでモジュールを扱いやすくするために必要な記述

  module Notifiable
    extend ActiveSupport::Concern # Railsでモジュールを扱いやすくするために必要な記述
    include Rails.application.routes.url_helpers
  
    def message
      notifiable.notification_message
    end
  
    def notifiable_path
      notifiable.notification_path
    end
  end
end