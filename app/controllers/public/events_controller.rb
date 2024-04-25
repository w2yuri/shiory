class Public::EventsController < ApplicationController
  def index
    @posts = current_customer.posts

    pp '-------------------'
    pp @posts
    # 下記のリクエストに対するレスポンスを定義するための記述
    # ブラウザがHTMLのレスポンスをリクエストした時
    # ブラウザがJSONのレスポンスをリクエストした時
    respond_to do |format|
      format.html
      format.json { render 'calendar' }
    end
  end
end