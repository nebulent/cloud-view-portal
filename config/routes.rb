Cloudview::Application.routes.draw do
  resources :terminals
  resources :remote_sessions, only: [:create, :destroy]
end
