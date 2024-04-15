class SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word]) # 変数名を@postsに修正
    end
  end
end
