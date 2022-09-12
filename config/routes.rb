Rails.application.routes.draw do
  root 'session#new'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
  resources :users do
    resources :friendships, only: %i(create update destroy)
  end
  resources :passwords
  resources :posts  do
    resources :comments, only: %i(create)
    resources :likes, only: %i(create destroy)
  end
end
