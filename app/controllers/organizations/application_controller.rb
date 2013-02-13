class Organizations::ApplicationController < ApplicationController

  before_filter :authenticate_head!
  before_filter :fetch_organization

  def event (attrs)
    event_params = {:entity => self.class.name, :name => self.action_name}
    @event_logger ||= current_organization.log(event_params)
  end

  def current_organization
    fetch_organization
  end

  def fetch_organization
    @organization ||= current_head.organization
  end

end
