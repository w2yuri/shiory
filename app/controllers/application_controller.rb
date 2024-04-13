class ApplicationController < ActionController::Base
  # すべてのアクションが実行される前に、ユーザーの認証チェック
  before_action :authenticate_customer!
end
