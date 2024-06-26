class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    customer = Customer.find(params[:id])
    current_customer.follow(customer)
    redirect_to request.referer
  end

  def destroy
    customer = Customer.find(params[:id])
    current_customer.unfollow(customer)
    redirect_to request.referer
  end

  def followings
    customer = Customer.find(params[:id])
    @customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:id])
    @customers = customer.followers
  end
end
