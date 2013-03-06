class Users::DashboardController < Users::ApplicationController

  def index
    @connections = current_user.connections
    @guac_check_path = ENV['VAM_GUAC_RELAY'] + "/guacamole/configs"
  end

end
