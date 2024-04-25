class Public::SessionsController < Devise::SessionsController
  before_action :authenticate_customer!

  def after_sign_in_path_for(resource)
     flash[:notice] = "ログインしました。"
     customer_path(current_customer)
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
     root_path
  end

  #二重ログイン防止
  def prohibit_multiple_login
    redirect_to root_path
  end

  # ゲストログイン用
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password])
  end

  protected



  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
