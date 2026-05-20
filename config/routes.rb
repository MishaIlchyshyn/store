Rails.application.routes.draw do
  root "products#index"

  resource :session
  resource :sign_up

  resources :passwords, param: :token
  resources :wishlists do
    resources :wishlist_products, only: [ :update, :destroy ], module: :wishlists
  end

  resources :products do
    resource :wishlist, only: [ :create ], module: :products
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
    root to: redirect("/settings/products")

    resources :users
    resources :products
  end
end
