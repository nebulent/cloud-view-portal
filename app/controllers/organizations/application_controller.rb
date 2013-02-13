class Organizations::ApplicationController < ApplicationController

  before_filter :authenticate_head!
  before_filter :fetch_organization

  def current_organization
    fetch_organization
  end

  def fetch_organization
    @organization ||= current_head.organization
  end

end
