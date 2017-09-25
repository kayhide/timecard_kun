Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :records, only: [:new] do
    post :open
    post :close
  end
end
