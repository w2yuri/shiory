class Admin::PostsController < ApplicationController
 before_action :authenticate_admin_admin!
  
  def index
    @posts = Post.all
    @post = Post.new
    # リクエストパラメータにfilterが含まれているかどうかを確認
     if params[:filter]
    # 特定の顧客に関連する投稿をフィルタリングし表示
       @posts = Post.where(customer_id: params[:filter])
    # filterパラメータが提供されていない場合、すべての投稿を取得
     else
       @posts = Post.all
     end
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
  end
  
  
  # 管理者機能によって修正の可能性：有
  def update
     @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to posts_path, notice: "投稿が更新されました。"
    else
       render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  # 検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  private
  
  def post_params
    params.require(:post)
    .permit(:title, :contents, :post_image, travel_tasks_attributes: [:id, :title, :contents, :task_image, :_destroy])
    # .merge メソッド＝新しいハッシュを作成し、指定されたハッシュとマージ。
    # post レコードのcustomer_id属性に、現在のユーザーのIDを割り当てるためのもの。これにより、認証されたユーザーが投稿を作成できる。
    .merge(customer_id: current_customer.id)
  end
end
