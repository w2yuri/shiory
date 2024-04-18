class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admon_customer_path(@customer), notice: "顧客情報が更新されました。"
    else
      render :edit
    end
  end
  
  def get_profile_image
  end
  
  # 検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_active, :profile_image)
  end
end
