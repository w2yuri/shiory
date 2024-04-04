class Public::UsersController < ApplicationController
  # # ログインしていない場合、ログインページへリダイレクトする
  # before_action :authenticate_customer!
  # # 他のユーザーのプロフィールを編集時、リダイレクトされるフィルター定義
  # before_action :ensure_correct_user, only: [:edit, :update]
  
  
  def index
    @users = User.all
  end
  
  def edit
  end

  def show
    @user = Customer.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end 
  end
  
  def get_profile_image
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image[])
  end 
  
  def ensure_correct_user
    @user = User.find(params[:id])
   unless @user == current_user
    redirect_to user_path(current_user)
   end
  end
  
end
