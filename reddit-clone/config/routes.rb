Rails.application.routes.draw do
  root 'subs#index'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new, :create]
  end
end
