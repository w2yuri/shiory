class Public::TravelTaskCommentsController < ApplicationController

  def create
    # @travel_task = TravelTask.find(comment_params[:travel_task_id])
    # @comment = TravelTaskComment.new(comment_params)
    # @comment.customer_id = current_customer.id
    # @comment.travel_task_id = @travel_task.id
    # @comment.save
    @travel_task = Post.find(params[:post_id]).travel_tasks.find(comment_params[:travel_task_id])
    @travel_task.travel_task_comments.new(comment_params).save
    render 'create'
  end

  def destroy
    # @travel_task = TravelTask.find(params[:post_id])
    @travel_task = Post.find(params[:post_id]).travel_tasks.find(params[:travel_task_id])
    @travel_task.travel_task_comments.find(params[:id]).destroy
    render 'create'
  end

  private

  def comment_params
    params.require(:travel_task_comment).permit(:content, :travel_task_id).merge(customer_id: current_customer.id)
  end
end
