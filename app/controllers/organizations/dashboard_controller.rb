class Organizations::DashboardController < Organizations::ApplicationController
  def logs
    respond_to do |fmt|
      fmt.html { render 'logs' }
      fmt.json { render :json => current_organization.events.to_json }
    end
  end
end
