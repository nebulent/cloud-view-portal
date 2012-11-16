Cloudview::Application.routes.draw do
  devise_for :users
  devise_for :heads, path: 'organization', controllers: {
    registrations: 'organizations/registrations'
  }

  namespace :organizations do
    resources :terminals
    resources :remote_sessions, only: [:create, :destroy]
  end

  match '/pages/:action', controller: "pages", as: "pages"
  root to: 'pages', action: 'index'

end
