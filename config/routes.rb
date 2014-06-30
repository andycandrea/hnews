Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles, only: [:index, :show]

  match '/signup', to: 'users#new', via: 'get'
  match '/signup', to: 'users#create', via: 'post'
  match '/submit', to: 'articles#new', via: 'get'
  match '/submit', to: 'articles#create', via: 'post'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signin', to: 'sessions#create', via: 'post'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
