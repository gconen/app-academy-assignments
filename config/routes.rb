Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:new]
  end
  resources :cat_rental_requests, only: [:index, :create, :edit, :update, :show, :new] do
    patch 'approve', on: :member
    patch 'deny', on: :member
  end

  resources :users

  resource :session do
    delete "/:id/remote_logout" => "sessions#remote_logout", as: :remote_logout
  end
end
