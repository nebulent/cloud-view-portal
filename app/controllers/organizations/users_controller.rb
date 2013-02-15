class Organizations::UsersController < Devise::RegistrationsController
  layout 'organizations/application'

  def event
    event_params = {:entity => self.class.name, :name => self.action_name}
    @event_logger ||= current_organization.log(event_params)
  end

  def create
    build_resource(params[:user])

    if resource.save
      flash.now[:success] = 'The user was successfully added'
      event.info(:message => "User with id #{resource.id} has been registered")
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
    @organization ||= current_organization
    hash ||= resource_params || {}
    self.resource = @organization.users.new(hash)
  end

  def current_organization
    orgs = current_head.organizations
    id = session[:current_org_id] || orgs.first.id
    @organization ||= orgs.find(id)
  end
end
