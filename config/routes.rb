Rails.application.routes.draw do
  # Users
  resources :users, only: [:index, :show] do
    # Posts for a specific user
    resources :posts, only: [:index, :show]
  end
end