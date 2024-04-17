class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @commenr = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = @post.id
    @comment.save
  end 
  
  def destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments
    Commenr.find_by(id: params[:id], post_id: params[:post_id].destroy)
  end 
  
  private
  
  def comment_params
    params.require(:comment).permit(comment)
  end 
end 