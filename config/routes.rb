Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:show, :index] do
    patch 'complete', on: :member
  end
end
