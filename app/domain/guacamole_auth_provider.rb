class GuacamoleAuthProvider
  InvalidCredentialsError = Class.new(StandardError)

  class << self

    def valid_credentials?(username, password)
      user = User.find_by_email(username)
      user and user.valid_password?(password)
    end

    def user_connections (username, password)
      raise InvalidCredentialsError.new unless valid_credentials?(username, password)

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
