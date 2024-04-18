class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = @post.id
    @comment.save
  end 
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end 
  
  private
  
  def comment_params
    params.require(:comment).permit(:content) 
  end 
end 