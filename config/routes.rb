Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles, only: [:new, :create, :index]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/submit', to: 'articles#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
