class Public::TravelTaskCommentsController < ApplicationController

  def create
    # params[:post_id]を使用し、コメントを追加する対象の投稿（Post）を特定。
    # その投稿に紐づくTravelTaskを、comment_params[:travel_task_id]を使用して特定。
    # 新しいコメントを作成するため、特定された@travel_taskに対して、travel_task_comments.new(comment_params)を呼び出す。
    @travel_task = Post.find(params[:post_id]).travel_tasks.find(comment_params[:travel_task_id])
    @travel_task.travel_task_comments.new(comment_params).save
     # チャットの保存に失敗した場合、jsのエラーメッセージを表示し、チャットの保存にしたら続行
    render :validate, formats: :js unless @travel_task.save
  end

  def destroy
    # params[:post_id]を使用し、コメントが属する投稿（Post）を特定。
    # その投稿に紐づくTravelTaskを、params[:travel_task_id]を使用して特定。
    # その旅行タスクに紐づくTravelTaskCommentを、params[:id]を使用し特定。
    # 特定されたコメントをデータベースから削除。
    @travel_task = Post.find(params[:post_id]).travel_tasks.find(params[:travel_task_id])
    @travel_task.travel_task_comments.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:travel_task_comment).permit(:content, :travel_task_id).merge(customer_id: current_customer.id)
  end
end
