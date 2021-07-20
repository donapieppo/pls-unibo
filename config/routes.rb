Rails.application.routes.draw do
  get 'auth/google_oauth2',          as: 'google_login'
  get 'auth/developer',              as: 'developer_login'
  get 'auth/shibboleth',             as: 'shibboleth_login'
  get 'auth/google_oauth2/callback', to: 'logins#google_oauth2'
  get 'auth/shibboleth/callback',    to: 'logins#shibboleth'
  post 'auth/developer/callback',    to: 'logins#developer'
  get 'login',                       to: 'logins#index',  as: :login
  get 'logins/logout',               to: 'logins#logout', as: :logout

  concern :contactable do
    member do
      post :add_contact
      delete :remove_contact
    end
    resources :contacts, only: [:index, :new, :create]
  end

  concern :resourceble do
    member do
      get  :choose_resource
      post :add_resource
      delete :remove_resource
    end
    resources :resources, only: [:index, :new, :create]
  end

  concern :bookable do
    resources :bookings, only: [:index, :new, :create] do
      post :new_user, on: :collection
    end
  end

  resources :resources
  resources :organizations, only: [:index, :show]
  resources :bookings
  resources :users do
    get :myedit, on: :collection
    get :me, on: :collection
  end
  
  resources :contacts do
    delete :delete_avatar, on: :member
  end

  resources :areas, concerns: :contactable

  resources :projects, concerns: :contactable do
    resources :editions
  end

  resources :editions, concerns: [:resourceble, :contactable, :bookable] do
    resources :events
  end

  resources :events, concerns: [:resourceble, :contactable, :bookable] 
  resources :resource_containers, concerns: [:resourceble]
  resources :resourcess, only: [:edit, :destroy]

  resources :clusters
  resources :schools

  post '/search', to: 'home#search', as: :search

  get "/presentazione", to: "home#presentazione", as: "presentation"
  get "/contatti", to: "home#contacts", as: "contacts_page"
  get "/privacy", to: "home#privacy", as: "privacy"
  root "home#index"

  Area.find_each do |a|
    get "/#{a.slug}", to: "areas#show", id: a.id
  end
end
