class Public::TravelTaskCommentsController < ApplicationController
  
  def create
    @travel_task = Travel_Task.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.travel_task_id = @travel_task.id
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
