class Public::TravelTaskCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @travel_task = TravelTask.find(comment_params[:travel_task_id])
    @comment = TravelTaskComment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.travel_task_id = @travel_task.id
    render :validate, formats: :js unless @comment.save
  end

  def destroy
     @travel_task = Post.find(params[:post_id]).travel_tasks.find(params[:travel_task_id])
     @travel_task.travel_task_comments.find(params[:id]).destroy
     render 'destroy'
  end

  private

  def comment_params
    params.require(:travel_task_comment).permit(:content, :travel_task_id)
  end
end