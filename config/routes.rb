Rails.application.routes.draw do
  resources :resources
  resources :organizations
  resources :areas
  
  resources :projects do
    resources :editions
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resouorce, on: :member
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :editions do
    resources :events
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resouorce, on: :member
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end
  resources :events do
    get  :choose_resource, on: :member
    post :add_resource, on: :member
    delete :remove_resouorce, on: :member
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :contacts

  resources :resources do
    resources :resource_items, only: [:new, :create, :update]
  end
  resources :resource_items, only: [:edit, :destroy]

  root "home#index"
end
