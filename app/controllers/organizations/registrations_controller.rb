class Organizations::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for (resource)
    organizations_dashboard_path 'index'
  end

end
