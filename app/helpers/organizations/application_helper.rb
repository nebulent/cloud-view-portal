module Organizations::ApplicationHelper
  def current_organization
    orgs = current_head.organizations
    id = session[:current_org_id] || orgs.first.id
    @organization ||= orgs.find(id)
  end
end
