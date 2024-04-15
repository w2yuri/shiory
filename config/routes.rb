Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/admin', to: 'admin/homes#top', as: 'admin_root'
  # 退会処理
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'public_customers_unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'
  # 検索機能
  get "search" => "searches#search"

  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲストログイン用
  devise_scope :customer do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :relationships, only: [:create, :destroy]
      get 'followings/:id' => 'relationships#followings', as: 'followings'
      get 'followers/:id' => 'relationships#followers', as: 'followers'
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :coments, only: [:create, :destroy]
    # 追加機能
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
    resources :chats, only: [:create, :show]
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }, as: :admin

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :update, :destroy]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
