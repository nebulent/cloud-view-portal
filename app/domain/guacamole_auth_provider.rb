class GuacamoleAuthProvider
  class << self

    def user_connections (user)
      connections = user.connections.select do |conn|
        conn.protocol != :ssh
      end.map do |conn|
        {
          name: conn.terminal.uri,
          protocol: conn.protocol,
          host: conn.terminal.uri,
          port: conn.port,
          password: conn.credentials
        }
      end

      { username: user.email, connections: connections }
    end

  end
end
