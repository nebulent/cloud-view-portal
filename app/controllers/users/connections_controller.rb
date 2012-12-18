class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = current_user.connections.find(params[:id])

    if connection.protocol == :ssh
      @ssh_relay_host = ENV['CVP_SSH_RELAY']
    else
      redirect_to ENV['CVP_GUAC_RELAY'] + "/guacamole"
    end
  end

  def credentials
    connection = current_user.connections.find(params[:id])
    render json: connection
  end

end
