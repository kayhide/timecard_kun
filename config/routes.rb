Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [] do
    resources :records, only: [] do
      collection do
        post :start
        post :finish
      end
    end
  end

  namespace :admin do
    namespace :records do
      resources :printables, only: [:index]
    end
    resources :records, only: [:index, :create, :update, :destroy]
    resources :users do
      member do
        put :hidden, controller: 'users/hidden', action: :create
        delete :hidden, controller: 'users/hidden', action: :destroy
      end
      resources :records, only: [:index, :create, :update, :destroy]
    end
  end
end
