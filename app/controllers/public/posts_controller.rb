class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
    # @post.travel_tasks = 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to posts_path
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
    .permit(:title, :contents, post_images: [], travel_tasks_attributes: [:id, :title, :contents, :task_image, :_destroy])
    .merge(customer_id: current_customer.id)
  end

  def ensure_customer
    @posts = current_customer.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to public_posts_path unless @post
  end
end