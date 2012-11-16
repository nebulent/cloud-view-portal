class Users::DashboardController < Users::ApplicationController

  def index
    @connections = current_user.connections
  end

end
