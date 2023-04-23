Rails.application.routes.draw do
  devise_for :users

  root "games#index"

  resources :games, only: [:index, :show, :create] do
    resources :players, only: [:create]
    resources :moves, only: [:create]
  end
end
