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

  resource :records, only: [:new] do
    post :open
    post :close
  end
end
