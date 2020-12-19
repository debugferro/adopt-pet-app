Rails.application.routes.draw do
  devise_for :users
  root to: 'pets#index'

  resources :pets do
   resources :requests,  only: [:create, :destroy]
  end

  resources :requests, only: [:index] do
    resources :messages, only: [:index, :create]
  end

  resources :users, only: [:show, :update]
  resources :users, only: [] do
    get '/myposts', to: 'users#show_my_posts'
  end

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
