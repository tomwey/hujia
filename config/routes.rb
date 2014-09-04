HujiaWebsite::Application.routes.draw do

  root to: 'home#index'
  
  devise_for :users, :path => "account", :controllers => { 
    :registrations => "users/registrations",
    :sessions => "users/sessions"
  }
  
  devise_scope :user do
    get '/u/sign_up' => 'users/registrations#new', :user => { :user_type => 'customer' }
    get '/coach/sign_up' => 'users/registrations#new', :user => { :user_type => 'coach' }
    get '/school/sign_up' => 'users/registrations#new', :user => { :user_type => 'school' }
  end
  
  # match 'u/sign_up' => 'users/registrations#new', :user => { :user_type => 'customer' }, via: :get
  match 'account/update_private_token', to: 'users#update_private_token', via: :post, as: :update_private_token_account
  
  # mount Sidekiq::Web, at: "/sidekiq"
  
  resources :appointments, only: [:index, :create, :destroy]
  resources :schools, only: [:show] do
    member do
      get :comments
    end
  end
  
  resources :coaches, only: [:show] do
    member do
      get :comments
    end
  end
  
  resources :pages, path: "wiki", only: [:index, :show]
  
  # resources :active_codes, only: [:update]
  
  resources :coupons do
    member do
      match "user/:user_id" => "coupons#user_index", :via => :put, :as => :getted
    end
  end
  
  resources :comments
  
  match '/search' => 'search#index', :as => :search, via: :get
  match '/search/coaches' => 'search#coaches', :as => :search_coaches, via: :get
  
  namespace :cpanel do
    root to: 'home#index'
    resources :site_configs
    resources :customers, only: [:index, :destroy, :show] # 普通用户
    resources :schools
    resources :coaches
    resources :appointments, only: [:index, :show, :destroy] # 预约
    resources :coupons, except: [:new, :show, :create]
    resources :comments
    resources :banners, :path => "ads"
    resources :pages, :path => "wiki"
  end
  
  resources :users, :path => "" do
    member do
      get :appointments
      get :coupons
      get :actived_coupons
      get :active_code
      put :active
      get :comments
      get :uncomments
    end
  end
  
end
