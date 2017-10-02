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
    resources :records, only: [:index]
    resources :users do
      member do
        put :hidden, controller: 'users/hidden', action: :create
        delete :hidden, controller: 'users/hidden', action: :destroy
      end
    end
  end
end
