class Organizations::RegistrationsController < Devise::RegistrationsController

  def after_sign_in_path_for (resource)
    organizations_terminals_path
  end

  def after_sign_up_path_for (resource)
    organizations_terminals_path
  end

end
