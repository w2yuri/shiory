class SearchesController < ApplicationController
  before_action :login_check

  def search
    @model = params[:model]
    @contents = params[:contents]
    
   if @model == "Customer"
      @records = Customer.search_for(@contents)
   else
      @records = Post.search_for(@contents) 
   end
  end
  
  private
  
  # 顧客もしくは管理者がログインしている時のみ検索ボックスを表示。それ以外はログイン認証。
  def login_check
    if customer_signed_in?
      return true
    elsif admin_signed_in?
      return true
    else
      return authenticate_customer!
    end
  end
end
