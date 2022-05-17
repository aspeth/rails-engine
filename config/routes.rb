Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      resources :items, only: [:index, :show, :create]
    end
  end
end
