Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    resources :records, only: [] do
      collection do
        post :start
        post :finish
      end
    end
  end

  namespace :admin do
    resources :records, only: [:index]
  end
end
