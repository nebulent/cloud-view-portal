class Organizations::ApplicationController < ApplicationController
  before_filter :authenticate_head!

  def event
    event_params = {:entity => self.class.name, :name => self.action_name}
    @event_logger ||= current_organization.log(event_params)
  end

  def current_organization
    orgs = current_head.organizations
    id = session[:current_org_id] || orgs.first.id
    @organization ||= orgs.find(id)
  end
end
