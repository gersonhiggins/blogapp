Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:create, :new]
    
      post 'like', to: 'likes#create', as: 'like'
      delete 'unlike', to: 'likes#destroy', as: 'unlike'
    end
  end

  get 'posts/new', to: 'posts#new', as: 'new_post'
  get 'posts/:post_id/comments/new', to: 'comments#new', as: 'new_comment'
end
