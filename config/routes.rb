Rails.application.routes.draw do
  resources :lists do
    member do
      put :sort
    end
  end
  resources :notifications
  resources :customers
  resources :addresses
  devise_for :users
  get "static_pages/landing_page"
  get "static_pages/dashboard"
  resources :people do
    member do
      get :hovercard
    end
  end
  resources :tasks do
    collection do
      post :preview
    end
  end
  resources :artists
  resources :comments
  get "home/index"
  resources :posts
  resources :movies do
    collection do
      post :search
    end
  end
  resources :messages do
    member do
      post :edit
      patch :upvote
      patch :downvote
      patch :bookmark
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  get :cookies, to: "cookies#index"
  get "counter", to: "counter#show"
  post "increment", to: "counter#increment"
  post "decrement", to: "counter#decrement"

  root "static_pages#landing_page"
end
