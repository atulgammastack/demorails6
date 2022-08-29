Rails.application.routes.draw do
  root 'session#new'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
  resources :users
  resources :passwords
  resources :posts  do
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]
  end
end
