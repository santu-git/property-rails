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
    get 'geo/lookup'
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
    resources :users, only: [:index], path: 'user'
    post 'users/token', path: 'user/token'
  end

  namespace :api do
    namespace :v1 do
      resources :ages, only: [:index]
      resources :availabilities, only: [:index]
      resources :departments, only: [:index]
      resources :frequencies, only: [:index]
      resources :media_types, only: [:index], path: 'mediatypes'
      resources :qualifiers, only: [:index]
      resources :sale_types, only: [:index], path: 'saletypes'
      resources :styles, only: [:index]
      resources :tenures, only: [:index]
      resources :types, only: [:index]
      resources :users, only: [:index], path: 'user'
      resources :agents, only: [:index]
      resources :branches, only: [:show]
      get 'listings/search'
      get 'categorizations/index', path: 'categorizations'
    end
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
