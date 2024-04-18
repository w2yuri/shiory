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
      redirect_to admin_customer_path(@customer), notice: "顧客情報が更新されました。"
    else
      render :edit
    end
  end
  
  def get_profile_image
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_active, :profile_image)
  end
end
