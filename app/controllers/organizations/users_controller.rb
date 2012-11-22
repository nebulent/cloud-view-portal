class Organizations::UsersController < Devise::RegistrationsController

  def create
    build_resource(params[:user])

    if resource.save
      flash.now[:success] = 'The user was successfully added'
      return redirect_to after_sign_up_path_for(resource)
    else
      render 'new'
    end
  end

  def after_sign_up_path_for (resource)
    organizations_dashboard_path('index')
  end

  private

  def build_resource (hash=nil)
    @organization ||= current_head.organization
    hash ||= resource_params || {}
    self.resource = @organization.users.new(hash)
  end

end
