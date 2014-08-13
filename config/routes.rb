Rails.application.routes.draw do
  root to: 'articles#index'

  concern :commentable do
    resources :comments, only: :create
  end

  concern :votable do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
  
  resources :articles, only: [:index, :show], concerns: [:votable, :commentable]
  resources :comments, only: [], concerns: [:votable, :commentable]  
  resources :users, only: [:edit, :update]
  resources :password_resets, only: [:edit, :update]

  match '/signup', to: 'users#new', via: 'get'
  match '/signup', to: 'users#create', via: 'post'
  match '/submit', to: 'articles#new', via: 'get'
  match '/submit', to: 'articles#create', via: 'post'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signin', to: 'sessions#create', via: 'post'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/reset', to: 'password_resets#new', via: 'get'
  match '/reset', to: 'password_resets#create', via: 'post'
end
