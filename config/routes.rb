Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"

  devise_for :users
  resources :connections, only: %i[ index new create destroy ]

  resources :contractors do
    resources :jobs, only: %i[ new create edit update destroy ]
    resources :ratings, only: %i[ new create edit update ]
  end

  namespace :admin do
    resources :users, only: %i[ index show ] do
      member do
        post :reset_password
      end
    end
    resources :contractors, only: %i[ index ]
  end
end
