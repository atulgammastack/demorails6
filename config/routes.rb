Rails.application.routes.draw do
  get 'chats', to: 'chatting#index'
  devise_for :users
  devise_scope :user do
    root "devise/sessions#new"
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/session#create'
    get 'logout', to: 'devise/sessions#destroy'
    resources :users do
      resources :friendships, only: %i(create update destroy)
    end
  end
  resources :passwords
  resources :posts  do
    resources :comments, only: %i(create)
    resources :likes, only: %i(create destroy)
  end
  resources :conversations do
    resources :messages
  end
end
