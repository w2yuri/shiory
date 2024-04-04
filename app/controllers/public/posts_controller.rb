class Public::PostsController < ApplicationController
  before_action :ensure_customer, only: [:edit, :update, :destroy]
  
  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    post = Post.new(post_params)
    post.save
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to public_posts_path
    else
       render :edit
    end 
  end
  
  def destroy
    @post.destroy
  end 
  
  private
  
  def post_params
    params.require(:post).permit(:title, :contents, :post_images)
  end
  
  def ensure_user
    @posts = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to public_posts_path unless @post
  end
end