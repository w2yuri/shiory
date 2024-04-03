class Public::PostsController < ApplicationController
  
  # new/createも作成
  
  def index
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
  end

  def show
  end

  def edit
  end
  
  
  private
  def post_params
    params.require(:post).permit(:title, :contents, :post_images)
  end
end