Rails.application.routes.draw do
  root "products#index"

  resource :session
  resources :passwords, param: :token
  resource :sign_up

  resources :products do
    resources :subscribers, only: %i[create], controller: "products/subscribers"
    resource :unsubscribe, only: [ :show ], controller: "products/unsubscribe"
  end

  namespace :settings do
    root to: redirect("/settings/profile")

    resource :password, only: %i[ show update ]
    resource :profile, only: %i[ show update destroy ] do
      get "confirm_email", on: :collection
    end
  end

  namespace :store do
    resources :users
  end
end
