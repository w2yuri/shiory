class Admin::PostsController < ApplicationController
 before_action :authenticate_admin_admin!

  def index
    # @posts = Post.all
    @post = Post.new
    # リクエストパラメータにfilterが含まれているかどうかを確認
     if params[:filter]
    # 特定の顧客に関連する投稿をフィルタリングし表示
       @posts = Post.where(customer_id: params[:filter])
    # filterパラメータが提供されていない場合、すべての投稿を取得
     else
       @posts = Post.where(status: true)
     end
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @comment = Comment.new
    @travel_task_comment = TravelTaskComment.new
    @comments = @post.comments
    @post.status == false && @post.customer != current_customer
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
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
