Rails.application.routes.draw do
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'

  # Route for listing all posts for a user
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'

  # Route for showing a specific post for a user
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
end