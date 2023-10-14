Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:destroy]
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          resources :comments
          resources :likes
        end
      end
    end
  end

  get '/users/:user_id/posts/:post_id/comments/new', to: 'comments#new', as: 'new_user_post_comment'
  post '/users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'user_post_comments'
  post '/users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'user_post_likes'
end
