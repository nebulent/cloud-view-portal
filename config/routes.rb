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
      get :edit_organization
      post :update_organization
      post :switch_organization
    end

    resources :policies, only: [:index, :new, :create, :destroy]
    resources :terminals do
      resources :connections
    end

    resources :aws_tokens

    match '/dashboard/:action', controller: "dashboard", as: "dashboard"
  end

  match '/pages/:action', controller: "pages", as: "pages"
  root to: 'pages', action: 'index'
end
