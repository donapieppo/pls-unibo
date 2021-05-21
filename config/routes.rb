Rails.application.routes.draw do
  get 'auth/google_oauth2',          as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'logins#google_oauth2'
  get 'auth/developer',              as: 'developer_login'
  post 'auth/developer/callback',    to: 'logins#developer'
  get 'login',                       to: 'logins#index',  as: :login
  get 'logins/logout',               to: 'logins#logout', as: :logout

  resources :resources
  resources :organizations
  resources :areas
  resources :bookings
  resources :users do
    get :myedit, on: :collection
    get :me, on: :collection
  end
  
  resources :projects do
    resources :editions

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :editions do
    resources :events

    resources :bookings, only: [:index, :new, :create]
    resources :resources, only: [:index, :new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :events do
    resources :bookings, only: [:index, :new, :create]
    resources :resources, only: [:index, :new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :contacts

  resources :resource_containers do
    resources :resources, only: [:index, :new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member
  end
  resources :resourcess, only: [:edit, :destroy]

  get "/presentazione", to: "home#presentazione", as: "presentation"
  get "/contatti", to: "home#contacts", as: "contacts_page"
  get "/privacy", to: "home#privacy", as: "privacy"
  root "home#index"
end
