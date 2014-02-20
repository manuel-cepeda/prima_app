PrimaApp::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :venues
      resources :users
      resources :feedbacks
      resources :ratings
      resources :posts
      match '/search', :to => 'venues#search', via: [:get]
      match '/account', :to => 'users#account', via: [:get]
      match '/venues/:id/rating', :to => 'venues#rating', via: [:get]
    end
  end


  get "ember/start"

  match '/rate' => 'rater#create', :as => 'rate', via: [:get, :post]
  resources :vote_records

  resources :users
  resources :venues
  resources :feedbacks
  resources :ratings, only: :update
  root :to =>"venues#index"
  get '/login', :to => 'sessions#new', :as => :login
  get '/logins' => 'sessions#logins'
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]
  match '/logout', :to => 'sessions#destroy', via: [:get]
  match '/vote', :to => 'venues#vote', via: [:get]
  match '/list', :to => 'venues#list', via: [:get]
  match '/spreadsheet', :to => 'venues#spreadsheet', via: [:get]
  match '/data', :to => 'venues#data', via: [:get, :post]
  resources :posts, only: [:create, :destroy]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  # get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  # get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  # resources :products

  # Example resource route with options:
  # resources :products do
  # member do
  # get 'short'
  # post 'toggle'
  # end
  #
  # collection do
  # get 'sold'
  # end
  # end

  # Example resource route with sub-resources:
  # resources :products do
  # resources :comments, :sales
  # resource :seller
  # end

  # Example resource route with more complex sub-resources:
  # resources :products do
  # resources :comments
  # resources :sales do
  # get 'recent', on: :collection
  # end
  # end
  
  # Example resource route with concerns:
  # concern :toggleable do
  # post 'toggle'
  # end
  # resources :posts, concerns: :toggleable
  # resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  # namespace :admin do
  # # Directs /admin/products/* to Admin::ProductsController
  # # (app/controllers/admin/products_controller.rb)
  # resources :products
  # end
end