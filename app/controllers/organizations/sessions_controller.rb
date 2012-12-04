class Organizations::SessionsController < Devise::SessionsController

  def after_sign_in_path_for (resource)
    organizations_dashboard_path 'index'
  end

end
