class SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @model = params[:model]
    @contents = params[:contents]
    
   if @model == "Customer"
      @records = Customer.search_for(@contents)
   else
      @records = Post.search_for(@contents) 
   end
  end
end
