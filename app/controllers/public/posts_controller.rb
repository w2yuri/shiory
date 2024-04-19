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
       if params[:is_favorite]
         customer = Customer.find(params[:filter])
         favorite_post_ids = customer.favorites.pluck(:post_id)
         @posts = Post.where(id: favorite_post_ids)
       else
          @posts = Post.where(customer_id: params[:filter])
       end  
    # filterパラメータが提供されていない場合、すべての投稿を取得
     else
       @posts = Post.all
     end
  end

  def create
    @post = Post.new(post_params)
    # 投稿ボタンを押下した場合
    if params[:post]
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "投稿されました。"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    # 下書きボタンを押下した場合
    else
      if @post.update(is_draft: true)
        redirect_to post_path(@post), notice: "投稿を下書き保存しました。"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    end 
  end

  def show
    @post = Post.find(params[:id])
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