class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = @post.id
    @comment.save
    # コメントの保存に失敗した場合、jsのエラーメッセージを表示し、コメントの保存にしたら続行
    render :validate, formats: :js unless @comment.save
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
