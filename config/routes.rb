Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'search#merchant'
      get '/merchants/find_all', to: 'search#all_merchants'
      get '/items/find_all', to: 'search#all_items'
      get '/items/find', to: 'search#item'
      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      get '/items/:id/merchant', to: 'merchant_items#show'
      resources :items, only: [:index, :show, :create, :update]

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
    end
  end
end
