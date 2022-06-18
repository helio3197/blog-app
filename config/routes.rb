Rails.application.routes.draw do
  # devise_for :users

  devise_for :users,
             controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
             }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  namespace :api do
    resources :users, only: [:id] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show', as: 'user'
  # get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  # get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
end
