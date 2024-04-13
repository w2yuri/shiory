class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @post = Post.new
    # リクエストパラメータにfilterが含まれているかどうかを確認
     if params[:filter]
    # 特定の顧客に関連する投稿をフィルタリングし表示
       @posts = Post.where(customer_id: params[:filter])
    # filterパラメータが提供されていない場合、すべての投稿を取得
     else
       @posts = Post.all
     end
    # 12行〜16行までを条件演算子(三項演算子)にした場合
    # @posts = params[:filter] ? Post.where(customer_id: params[:filter]) :  Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to posts_path, notice: "投稿されました。"
    else
      render :new, alert: "投稿されませんでした。"
    end
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
  end

  def edit
    @post = Post.find(params[:id])
  end

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
    redirect_to posts_path, alert: "投稿が削除されました。"
  end

  private

  def post_params
    params.require(:post)
    .permit(:title, :contents, :post_image, travel_tasks_attributes: [:id, :title, :contents, :task_image, :_destroy])
    # .merge メソッド＝新しいハッシュを作成し、指定されたハッシュとマージ。
    # post レコードのcustomer_id属性に、現在のユーザーのIDを割り当てるためのもの。これにより、認証されたユーザーが投稿を作成できる。
    .merge(customer_id: current_customer.id)
  end

  def ensure_customer
    @posts = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end
end