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
  def login_check
    if customer_signed_in?
      return true
    elsif admin_admin_signed_in?
      return true
    else
      return authenticate_customer!
    end
  end
end
