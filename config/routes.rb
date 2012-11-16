Cloudview::Application.routes.draw do
  devise_for :users, only: [:sessions, :passwords]
  devise_for :heads, path: 'organization', controllers: {
    registrations: 'organizations/registrations'
  }

  namespace :organizations do
    devise_for :users, only: [:registrations], controllers: {
      registrations: 'organizations/users'
    }

    resources :terminals do
      resources :connections
    end

    resources :remote_sessions, only: [:create, :destroy]
    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  match '/pages/:action', controller: "pages", as: "pages"
  root to: 'pages', action: 'index'

end
