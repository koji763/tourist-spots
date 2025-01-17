Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  get "search", to: "tourist_spots#index"
  resources :users, only:[:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :likes
      get :reviews
    end
  end

  resources :tourist_spots, only:[:show, :new, :create, :edit, :update, :destroy] do
    resources :reviews, shallow: true
  end
  
  resources :favorites, only: [:create, :destroy]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
