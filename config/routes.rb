Rails.application.routes.draw do
  resources :resources
  resources :organizations
  resources :areas
  resources :bookings
  
  resources :projects do
    resources :editions

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :editions do
    resources :events

    resources :resources, only: [:index, :new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :events do
    resources :resources, only: [:index, :new, :create]
    resources :bookings, only: [:index, :new, :create]
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

  root "home#index"
end
