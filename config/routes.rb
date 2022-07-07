#  get 'auth/:provider/callback', to: 'sessions#create'
#  get '/login', to: 'sessions#new'
Rails.application.routes.draw do
  # No route matches [GET] "/nuovo-pls/auth/shibboleth/callback"
  #get '/nuovo-pls/auth/shibboleth/callback' do
  #  redirect 'https://www.dm.unibo.it/nuovo-pls/auth/shibboleth/callback'
  #end

  get 'auth/google_oauth2/callback', to: 'logins#google_oauth2'
  get 'auth/shibboleth/callback',    to: 'logins#shibboleth'

  get '/auth/failure' do
    flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
    redirect '/'
  end

  get 'login',                       to: 'logins#index',  as: :login
  get 'logins/logout',               to: 'logins#logout', as: :logout

  get "logins/no_access", to: 'logins#no_access', as: :no_access

  get 'who_impersonate',     to: 'impersonations#who_impersonate',    as: :who_impersonate
  post 'impersonate/:id',    to: 'impersonations#impersonate',        as: :impersonate
  post 'stop_impersonating', to: 'impersonations#stop_impersonating', as: :stop_impersonating

  # PAGES
  get '/workshop21', to: "pages#workshop21", as: :workshop21
  get '/workshop22', to: "pages#workshop22", as: :workshop22
  get '/scienza_al_cinema', to: "pages#scienza_al_cinema", as: :scienza_al_cinema
  get '/editions/282', to: redirect('/metodi_matematici_animazione')
  get '/metodi_matematici_animazione', to: "pages#metodi_matematici_animazione", as: :metodi_matematici_animazione

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
      get :new_student, on: :collection
      post :create_student, on: :collection
      # get :anew, on: :collection
      # post :acreate, on: :collection
    end
  end

  resources :resources
  resources :organizations, only: [:index, :show]
  resources :bookings do
    get :thankyou, on: :member
    post :confirm, on: :member
  end
  resources :users do
    get :myedit, on: :collection
    get :me, on: :collection
    get :forget_form, on: :collection
    post :forget, on: :collection
  end

  resources :contacts do
    delete :delete_avatar, on: :member
  end

  resources :contributions

  resources :projects, concerns: [:resourceble, :contactable] do
    resources :editions
  end

  resources :editions, concerns: [:resourceble, :contactable, :bookable] do
    resources :events
    resources :snippets
    # resources :bookings
  end

  resources :events, concerns: [:resourceble, :contactable, :bookable] do
    # resources :bookings
  end
  resources :resource_containers, concerns: [:resourceble]
  resources :resourcess, only: [:edit, :destroy]

  resources :snippets

  resources :clusters
  resources :schools

  post '/search', to: 'home#search', as: :search

  get "/presentazione", to: "home#presentazione", as: "presentation"
  get "/contatti", to: "home#contacts", as: "contacts_page"
  get "/privacy",  to: "home#privacy", as: "privacy"
  get "/archive",  to: "home#archive", as: "archive"

  root "home#index"

  resources :areas, concerns: :contactable

  Area.find_each do |a|
    get "/#{a.slug}", to: "areas#show", id: a.id
    get "/#{a.slug}/archive", to: "home#archive", id: a.id
  end
end
