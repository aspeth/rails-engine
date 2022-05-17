Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      resources :items, only: [:index, :show, :create, :update]

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
    end
  end
end
