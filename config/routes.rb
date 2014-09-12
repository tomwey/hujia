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
  
  resources :appointments, only: [:index, :create, :destroy] do
  end
  resources :schools, only: [:show] do
    member do
      get :comments
    end
  end
  
  resources :cities do
    collection do 
      match ":province_id" => "cities#province", :via => :get, :as => :province
    end
  end
  
  resources :colleges do
    collection do
      match ":city_id" => "colleges#city", :via => :get, :as => :city
    end
  end
  
  get "coaches?c=:name" => "coaches#index", as: :college_coaches
  resources :coaches, only: [:index, :show] do
    member do
      get :comments
    end
  end
  
  resources :pages, path: "", only: [:index, :show]
  
  # resources :active_codes, only: [:update]
  
  resources :coupons do
    member do
      # match "user/:user_id" => "coupons#user_index", :via => :put, :as => :getted
      post :getted
    end
  end
  
  resources :active_codes, only: [:create, :destroy, :new]
  
  match '/active/coupon:coupon_id'   => "active_codes#new", via: :get,  as: :active_coupon
  match 'vouchings/coupon:coupon_id' => "vouchings#create", via: :post, as: :coupon_vouchings
  
  resources :vouchings, only: [:new, :create, :destroy]
  
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
    resources :provinces, except: [:show, :destroy]
    resources :cities, except: [:show, :destroy]
    resources :colleges, except: [:show, :destroy]
  end
  
  match '/users/bind' => 'users#bind', as: :bind_users, via: :put
  
  match '*path', via: :all, to: 'home#error_404'
  
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
