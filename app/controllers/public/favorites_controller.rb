class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    # カスタマーが特定の投稿をお気に入りに追加するためのFavoriteオブジェクトを作成
    @favorite = current_customer.favorites.new(post_id: params[:post_id])
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    # カスタマーが特定の投稿をお気に入りに追加したかどうかを確認し、その結果を変数に代入
    @favorite = current_customer.favorites.find_by(post_id: params[:post_id])
    @favorite.destroy
    render 'replace_btn'
  end
end