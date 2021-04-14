Rails.application.routes.draw do
  resources :areas
  resources :activities do
    resources :editions
  end
  resources :editions do
    resources :events
  end
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root "home#index"
end
