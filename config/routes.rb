Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:create]
      
      # Like a post
      post 'like', to: 'likes#create', as: 'like'
      delete 'unlike', to: 'likes#destroy', as: 'unlike'
    end
  end
end
