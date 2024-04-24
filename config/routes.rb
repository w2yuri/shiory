Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/admin', to: 'admin/homes#top', as: 'admin_root'
  # 退会処理
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'public_customers_unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'
  # 検索機能
  get "search" => "searches#search"
  # カレンダー機能
  get 'events', to: 'events#index', defaults: { format: 'json' }

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
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      get :confirm
    end
    resources :relationships, only: [:create, :destroy]
      get 'followings/:id' => 'relationships#followings', as: 'followings'
      get 'followers/:id' => 'relationships#followers', as: 'followers'
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resources :travel_task_comments, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create]
    resources :chat_groups, only: [:index, :destroy]
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }, as: :admin

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]do
      resources :comments, only: [:create, :destroy]
      resources :travel_task_comments, only: [:create, :destroy]
    end
    resources :chat_groups, only: [:index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
