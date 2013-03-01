class Users::ApplicationController < ApplicationController
  before_filter :authenticate_user!

  def event
    event_params = {:entity => self.class.name, :name => self.action_name}
    @event_logger ||= current_user.log(event_params)
  end

  def current_tenant
    current_user.organization.subdomain
  end
  helper_method :current_tenant
end
