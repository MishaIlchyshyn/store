Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "products#index"
  resources :products do
    resources :subscribers, only: %i[create], controller: "products/subscribers"
    resource :unsubscribe, only: [ :show ], controller: "products/unsubscribe"
  end
end
