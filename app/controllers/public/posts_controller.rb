class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
     @post = Post.new
     @posts = Post.where(status: true).order(params[:sort])
    # リクエストパラメータにfilterが含まれているかどうかを確認
     if params[:filter]
       if params[:is_favorite]
         customer = Customer.find(params[:filter])
         favorite_post_ids = customer.favorites.pluck(:post_id)
         @posts = @posts.where(id: favorite_post_ids)
       else
          @posts = @posts.where(customer_id: params[:filter])
       end  
     end 
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿されました。"
    else
      render :new, alert: "投稿されませんでした。空欄がないか確認して下さい。"
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.status == false && @post.customer != current_customer
      # 下書きで自分の投稿したもの以外
      redirect posts_path
    end
    @customer = @post.customer
    @comment = Comment.new
    @travel_task_comment = TravelTaskComment.new
    @comments = @post.comments
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
    .permit(:title, :contents, :post_image, :status, travel_tasks_attributes: [:id, :title, :contents, :task_image, :_destroy])
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