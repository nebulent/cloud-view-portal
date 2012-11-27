Cloudview::Application.routes.draw do
  devise_for :users, only: [:sessions, :passwords], controllers: {
    sessions: 'users/sessions'
  }
  devise_for :heads, path: 'organization', controllers: {
    registrations: 'organizations/registrations'
  }

  namespace :users do
    resources :connections, only: [:show] do
      member do
        get :credentials
      end
    end

    resources :remote_sessions, only: [:create, :destroy]

    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  namespace :organizations do
    devise_for :users, only: [:registrations], controllers: {
      registrations: 'organizations/users'
    }

    resources :policies, only: [:index, :new, :create, :destroy]

    resources :terminals do
      resources :connections
    end

    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  match '/pages/:action', controller: "pages", as: "pages"
  root to: 'pages', action: 'index'

end
