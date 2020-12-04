Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  get 'items/search'
  resources :items do
    collection do
      get 'search'
    end
    resources :purchases, only: [:index, :create]
  end
end