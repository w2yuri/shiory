class Admin::PostsController < ApplicationController
# ログインできたらコメントアウト解除
# before_action :authenticate_admin!
  
  def index
    @posts = Post.all
    # @customer = Customer.find(params[:id])
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
  
  private
  
  def post_params
    params.require(:post)
    .permit(:title, :contents, :post_image, travel_tasks_attributes: [:id, :title, :contents, :task_image, :_destroy])
    # .merge メソッド＝新しいハッシュを作成し、指定されたハッシュとマージ。
    # post レコードのcustomer_id属性に、現在のユーザーのIDを割り当てるためのもの。これにより、認証されたユーザーが投稿を作成できる。
    .merge(customer_id: current_customer.id)
  end
end
