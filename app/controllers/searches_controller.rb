class SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @model = params[:model]
    @contents = params[:content]
    @method = params[:method]
    
   if @model == "customer"
      @records = Customer.search_for(@contents, @method)
   else
      @records = Post.search_for(@contents, @method) 
   end
  end
end
