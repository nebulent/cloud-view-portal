Cloudview::Application.routes.draw do
  devise_for :users
  devise_for :heads

  match '/pages/:action', :controller => "pages", :as => "pages"

  root to: 'pages', action: 'index'

  resources :terminals
  resources :remote_sessions, only: [:create, :destroy]
end
