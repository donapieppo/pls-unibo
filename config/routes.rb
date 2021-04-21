Rails.application.routes.draw do
  resources :organizations
  resources :areas
  
  resources :projects do
    resources :editions
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :editions do
    resources :events
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end
  resources :events do
    get  :choose_contact, on: :member
    post :add_contact, on: :member
    delete :remove_contact, on: :member
  end

  resources :contacts
  root "home#index"
end
