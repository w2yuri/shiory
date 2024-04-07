class Public::CustomersController < ApplicationController
# ログインしていない場合、ログインページへリダイレクトする
  # before_action :authenticate_customer!
  # # 他のユーザーのプロフィールを編集時、リダイレクトされるフィルター定義
  # before_action :ensure_correct_customer, only: [:edit, :update]
 
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
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer)
    else
      render "edit"
    end
  end

  def get_profile_image
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
