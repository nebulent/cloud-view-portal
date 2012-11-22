class ConnectionSessionHelper

  def initialize (connection)
    @connection = connection
    @session = connection.create_session
  end

  def create_session
    daemon = ProxyDaemon.new(connection)
    @session.update_attributes({
      pid: daemon.start!,
      host: daemon.host,
      port: daemon.port
    })
  end

  def destroy_session
    ProxyDaemon.new(terminal, @session).stop!
  end

end
