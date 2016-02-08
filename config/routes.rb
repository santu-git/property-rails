Rails.application.routes.draw do

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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
