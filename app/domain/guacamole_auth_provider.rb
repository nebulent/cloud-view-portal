class GuacamoleAuthProvider
  InvalidCredentialsError = Class.new(StandardError)

  class << self

    def get_user(username, password)
      user = User.find_by_email(username)
      unless user and user.valid_password?(password)
        raise InvalidCredentialsError.new
      end

      user
    end

    def user_connections (username, password)
      user = get_user(username, password)

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

      { username: user.email, connections: connections || [] }
    end

  end
end
