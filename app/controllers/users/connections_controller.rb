class Users::ConnectionsController < Users::ApplicationController

  def show
    connection = current_user.connections.find(params[:id])
    terminal = connection.terminal
    event.info(:message => "user connected to terminal ##{terminal.id}
                            via connection ##{connection.id}")

    if connection.protocol == :ssh
      @ssh_relay_host = ENV['CVP_SSH_RELAY']
      @token = SshEndpoint.create_token(connection)
      render 'show_ssh'
    else
      @guacamole_relay = ENV['CVP_GUAC_RELAY'] + "/guacamole"
      suffix = "/guacamole/client.xhtml?id=#{connection.protocol}-#{connection.terminal.uri}"
      @view_url = ENV['CVP_GUAC_RELAY'] + suffix
      render 'show_guac'
    end
  end

end
