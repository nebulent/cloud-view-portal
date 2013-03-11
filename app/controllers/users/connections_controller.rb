class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = current_user.connections.find(params[:id])
    terminal = connection.terminal
    event.info(:message => "user connected to terminal ##{terminal.id}
                            via connection ##{connection.id}")

    if connection.protocol == :ssh
      @ssh_relay_host = ENV['VAM_SSH_RELAY']
      @token = SshEndpoint.create_token(connection)
      render 'show_ssh'
    else
      @guacamole_relay = ENV['VAM_GUAC_RELAY'] + "/guacamole"
      @token = GuacamoleEndpoint.create_token(current_user, connection)
      suffix = "/client.xhtml?id=#{connection.protocol}-#{connection.terminal.uri}"
      @view_url = @guacamole_relay + suffix
      render 'show_guac'
    end
  end

  def leave
    connection = current_user.connections.find(params[:id])
    terminal = connection.terminal
    event.info(:message => "user disconnected from terminal ##{terminal.id}
                            via connection ##{connection.id}")    
    render :layout => false
  end

end
