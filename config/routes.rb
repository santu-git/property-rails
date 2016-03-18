Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  unauthenticated :user do
    root to: "home#index"
  end

  authenticated :user do
    root to: 'admin/dashboard#index', :as => 'authenticated_root'
  end

  namespace :admin do
    get 'branches/json'
    get 'dashboard/index'
    get 'assets/json'
    resources :ages
    resources :availabilities
    resources :departments
    resources :frequencies
    resources :media_types
    resources :qualifiers
    resources :styles
    resources :tenures
    resources :types
    resources :sale_types
    resources :agents
    resources :branches
    resources :listings
    resources :assets
  end

  devise_for :users,
    :path => 'accounts',
    :path_names => {
      :sign_in => 'login',
      :sign_up => 'new',
      :sign_out => 'logout',
      :password => 'secret',
      :confirmation => 'verification'
    }
end
