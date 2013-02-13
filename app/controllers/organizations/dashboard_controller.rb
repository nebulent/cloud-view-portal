class Organizations::DashboardController < Organizations::ApplicationController
  def logs
    respond_to do |fmt|
      fmt.html { render 'logs' }
      fmt.json do
        data = EventLogPresenter.events(current_organization, params)
        render :json => data
      end
    end
  end
end
