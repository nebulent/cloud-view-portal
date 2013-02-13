class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = current_user.connections.find(params[:id])
    terminal = connection.terminal
    event.info(:message => "user connected to terminal ##{terminal.id}
                            via connection ##{connection.id}")

    if connection.protocol == :ssh
      @ssh_relay_host = ENV['CVP_SSH_RELAY']
      @token = SshEndpoint.create_token(connection)
    else
      suffix = "/guacamole/client.xhtml?id=#{connection.protocol}-#{connection.terminal.uri}"
      redirect_to ENV['CVP_GUAC_RELAY'] + suffix
    end
  end

  def credentials
    connection = current_user.connections.find(params[:id])
    render json: connection
  end

end
