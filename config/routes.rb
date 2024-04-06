Rails.application.routes.draw do
  # scope module: :public do
  #   get 'relationships/followings'
  #   get 'relationships/followers'
  # end
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  get '/admin', to: 'admin/homes#top', as: 'admin_root'

  # 顧客用
  # URL /users/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # devise_scope :customers do
  #   resources :customers, only: [:index, :show, :edit, :update, :destroy]
  # end

  scope module: :public do
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :relationships, only: [:create, :destroy]
      get 'followings/:id' => 'relationships#followings', as: 'followings'
      get 'followers/:id' => 'relationships#followers', as: 'followers'
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :coments, only: [:create, :destroy]
    # 追加機能
    resources :groups, only: [:index, :show, :edit, :update, :destroy]
    resources :chats, only: [:create, :show]
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }, as: :admin

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :update, :destroy]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
