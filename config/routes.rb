Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :properties do
    resources :bookings, only: [:index, :new, :create]
  end

  resources :bookings, only: [:show, :destroy] do
    resources :reviews, only: [:new, :create, :edit, :update]
  end

  resources :reviews, only: [:destroy]

  resources :users, only: [:show] do
    get "bookings", to: "users#bookings"
    get "properties", to: "users#properties"
  end
end
