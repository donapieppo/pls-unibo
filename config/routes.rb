Rails.application.routes.draw do
  resources :resources
  resources :organizations
  resources :areas
  
  resources :projects do
    resources :editions

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :editions do
    resources :events

    resources :resources, only: [:new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :events do
    resources :resources, only: [:new, :create]
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resource, on: :member

    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :contacts

  resources :resource_contaiers do
    resources :resources, only: [:new, :create, :update]
  end
  resources :resourcess, only: [:edit, :destroy]

  root "home#index"
end
