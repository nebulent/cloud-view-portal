Cloudview::Application.routes.draw do
  devise_for :users, only: [:sessions, :passwords], controllers: {
    sessions: 'users/sessions'
  }
  devise_for :heads, path: 'organization', controllers: {
    registrations: 'organizations/registrations',
    sessions: 'organizations/sessions'
  }

  namespace :users do
    resources :connections, only: [:show]
    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  namespace :organizations do
    devise_for :users, only: [:registrations], controllers: {
      registrations: 'organizations/users'
    }

    resource :head, only: [:show] do
      get  :new_organization
      post :create_organization
      post :switch_organization
    end

    resources :policies, only: [:index, :new, :create, :destroy]
    resources :terminals do
      resources :connections
    end

    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  match '/guacamole/auth' =>  'guacamole_auth#check', via: [:post]
  match '/pages/:action', controller: "pages", as: "pages"
  match '/', to: 'users/dashboard#index', constraints: {subdomain: /.+/ }
  root to: 'pages', action: 'index'
end
