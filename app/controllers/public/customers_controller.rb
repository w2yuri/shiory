class Public::CustomersController < ApplicationController
  # ログインしていない場合、ログインページへリダイレクトする
  before_action :authenticate_customer!
  # 他のユーザーのプロフィールを編集時、リダイレクトされるフィルター定義
  before_action :ensure_correct_customer, only: [:edit, :update]

  # ゲストログイン用
  before_action :ensure_guest_customer, only: [:edit]


  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    # 投稿主に関連する投稿を取得し、作成日時の降順で並べ替え
    @posts = Post.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "登録情報が更新されました。"
    else
      render "edit", alert: "登録情報が更新されませんでした。"
    end
  end

  def get_profile_image
  end

  def unsubscribe
    @customer = Customer.find(current_customer.id)
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # 会員ステータスを退会に変更
    @customer.update!(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
   unless @customer == current_customer
    redirect_to customer_path(current_customer)
   end
  end

  # ゲストがユーザーの編集画面へのURLを直接入力した場合、メッセージを表示してユーザー詳細画面へリダイレクト
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to customer_path(current_customer) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

end
