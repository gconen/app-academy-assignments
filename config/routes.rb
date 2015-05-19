Rails.application.routes.draw do
  resources :users do
    resources :comments, only: [:new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:show, :index] do
    resources :comments, only: [:new]
    patch 'complete', on: :member
  end

  resources :comments, only: [:create]
end
