Rails.application.routes.draw do
  get 'ratings/new'
  get 'ratings/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'my_meals', to: 'meals#my_meals', as: :my_meals
  resources :meals, only: [:index, :new, :create, :show] do
    resources :ratings, only: [:new, :create]
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index]
end
