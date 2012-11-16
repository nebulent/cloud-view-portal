Cloudview::Application.routes.draw do
  devise_for :users
  devise_for :heads, path: 'organization', controllers: {
    registrations: 'organizations/registrations'
  }

  namespace :organizations do
    resources :terminals, :users
    resources :remote_sessions, only: [:create, :destroy]

    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  match '/pages/:action', controller: "pages", as: "pages"
  root to: 'pages', action: 'index'

end
