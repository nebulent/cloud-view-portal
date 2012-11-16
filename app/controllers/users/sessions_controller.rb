class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for (resource)
    users_dashboard_path('index')
  end
end
