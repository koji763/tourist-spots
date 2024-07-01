Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, only:[:index, :show, :create, :edit, :update, :destroy]
  resources :tourist_spots
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

end
