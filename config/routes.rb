Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:new, :create, :index]
  resources :users, only: [:new, :create]
end
